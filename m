Return-Path: <dmaengine+bounces-7569-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00DCB5AAD
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C31030161B0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84E29B79B;
	Thu, 11 Dec 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9yj8qo3"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975B2DF121;
	Thu, 11 Dec 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453216; cv=fail; b=YXCbebjYr880zZvniWwANfsRgaYusHbsnWhJHrow8DAESxSoGFdXdr+8E4Ym807R9s0aEyDLIsTbj5MWLgSskTFMoxWNdV3lDJOks0onkuhUG39CWEkE/1yXCHB8DuaukaogdrIWZp2Vc+OVrQTdZzV11wjwlWPL1isijnqFJQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453216; c=relaxed/simple;
	bh=yfu5jx3P3edOBvAG2CUB1wJ1UrFvd27lZIx9YCpcnd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3y8SFnhO2BM5IOZXN8MxZP70kXOE9Ci3BujksKy1h8waWpF2qoZZGrwH4HLKQJqjHvJaMAgy8s+pyg/qL0DKxox5pFdpP30ZDY80tvLBGdrLIvnXNrHjc7ww5Y+pGCrVTed5bfS9lw9qi/DoFpQmLlcvVpYRoa+ww/270mAq34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9yj8qo3; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJiyqsBQ3UY6yQpJtPS+o9+WeSp23m4qHRj+zCBgpup6JwABkuTsFDhOBLslNQnlG4CfIWgwq+uuvkOHynZvBwm87/+Y3wbw90eVJefcFSASI2a5Q+S49beyBazVPro0BLR70NwXHavKZWCTlWOFcFljSYifIlLEFgLdQyNdNnpguq7qXqj4HG4TSJqM0F+/iMme6fZqITQs0Jdr73U2MfSwEsJLOqPWypHglLVPd3hY9N8Z0AzHePdBUiG13AafUOo5Ml+LnojzyXBvTIzXiSTBF2BG52SPR00alYyONyT8U2+GuWSjuGAqnnpzNvtMPVB6DqhgSWRxhRIflm0qTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9rDSG1DccJwcka7tMKX3JJ0ACKo7nQ/9Xvw5tvovYM=;
 b=t/HHkSIipj2tIxjLNVEeODtJsEB8gBMV3bgMZJbLIstCg4EHmDTL+3dbFfonTN5KI0FIiMzpv0ys6K+aAWyajvgXg1fceWTZSAkcHqOHnQ54qLymw2OJIA2WTHDq8Dky3gfiHH9x9ySJ2N0SuD9r4usogK8brnAdBnf5yxK6HHY1ZH6TKIq7d6lGDIcFGYSv447x6OvEdlC0DH0gKSwN8nLBe5NN326c0l7YH+L41mJprLu3/orWUv5k7YxnmQFTX+87No1QuaqDg08yFo2YAGfDAgWFd2IZLobkTRNu1UyoKb3Nl0OhUFXz/ghIUMvMSN/SBn6AdOIqma+x5bYOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9rDSG1DccJwcka7tMKX3JJ0ACKo7nQ/9Xvw5tvovYM=;
 b=H9yj8qo3kHF2lAiWvOa4GWMF60VfzF06xm0WroVm2coh8zpyIrZHkVVXIOC4kjneXldCttc3a29Wvrz1jeLGW6lhQhJzBUYH5qCQK1auMTlyyR7V4JbPT9kPzt8f1e1+BjjjngQCxWCsB76VygpDIQy3hioQRIRD7sS9EAnaxgY=
Received: from PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 11:40:11 +0000
Received: from PH0PR12MB8126.namprd12.prod.outlook.com
 ([fe80::c04e:6257:19b7:5ee]) by PH0PR12MB8126.namprd12.prod.outlook.com
 ([fe80::c04e:6257:19b7:5ee%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:40:11 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Topic: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Index: AQHcWtriEx0Zhgd8hUGLg65M6Bj2QLUXUEOAgAN4phCAADKaAIAAM+wAgAEmh4A=
Date: Thu, 11 Dec 2025 11:40:11 +0000
Message-ID:
 <PH0PR12MB81260693EB981E79CB67092295A1A@PH0PR12MB8126.namprd12.prod.outlook.com>
References: <b2s6genayrgyicxawx2scpswfji3c62vxn7cgvpzwfbm6vodtx@5dseozibsrte>
 <20251210163228.GA3526502@bhelgaas>
In-Reply-To: <20251210163228.GA3526502@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-11T10:06:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8126:EE_|SA0PR12MB4399:EE_
x-ms-office365-filtering-correlation-id: c012deca-6835-4bb6-e57e-08de38aa0ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JBFlu55brdH5u6T4UqU8quSiYGw7ebyeNRg7BdcZJj/eMxgfm5ijDoqHjI2B?=
 =?us-ascii?Q?CAMp7oaTIlcxEfF8azB0Q1ARlZUbm5tCjmZmUHWakPNw6B16hiOpRiPGfNnF?=
 =?us-ascii?Q?xpgjS0Hean8BcqU6Gb59RUO+elC0lzm386OU7AMi9oWRJxk3tukI5+D351L9?=
 =?us-ascii?Q?swRUKtODq9BI2iMAKQ7ij4FXFHdFZ3uivPMGu+gmINvSHzc69jv9b3RizhqW?=
 =?us-ascii?Q?myf4VgYfj3iwXw/ENrV0g9UtB2/nV2CB41FZ6TQ/2xWWxLpZ1BTCxR7FkDng?=
 =?us-ascii?Q?bP9IS/Ep+pqLH+fIfFj7QptuCqacHNmxCIxkLGafhaCdelrvJMas3gV9E3x2?=
 =?us-ascii?Q?5nRxPueCuyNt1HhLkrRpNw9fdXzkQzRPw2RW5cdYW8E4u+vpGkaGR8H4ckH1?=
 =?us-ascii?Q?QeXumH8OqxTqpmaXcRLZPsoMS0XyKiYX33BTE+eGtS6CX73Z5kV82PxTjT/7?=
 =?us-ascii?Q?AM52kC2WkwWgqTFZnFlmDm8aqFETBMAMQS4WYjQI2SjPnVAl3a/nYyMVoVxw?=
 =?us-ascii?Q?PN/FmrqYeKsiRUan+aTDgPvh3mkffwaOsPiQNNgVAXsTeAfN24BhGxEfFDR6?=
 =?us-ascii?Q?ODHy64OH4D9Fw4C9oGN2fc2LvJtrbc4eeUaBeYjruZ82lmJrC1xP7RiNnZHm?=
 =?us-ascii?Q?p4GgJwM+9SQoreks1uyqkrUuUYnONwb8OYzE1ilG9EE7FWxBtOIedSuUc2es?=
 =?us-ascii?Q?kZIYUd1LmidTjAb+M3rrIrCD97KegCe9Y/ingHtRfhDRcinUBEqpVfZSawmH?=
 =?us-ascii?Q?w/Rj5Wb/kPT+WUGdWCUPrdVuAU3H0fNYvdpeUE818l5IFONF3BIrX9I5t2r0?=
 =?us-ascii?Q?rd9Jv7rVIm2iymq6x9FvEM4QD/NHMNwpXkJy2FkIQ9xetZkkA9hdYXJc/I2Q?=
 =?us-ascii?Q?RFdyKpphVACuF4E9K0qQbeg/P1jakElQ2BnRn575efceh4Z85v7Lse0UmXuC?=
 =?us-ascii?Q?ZpBm1GP7b+EFBSG8K1Ncl7PlYlLa9jCGjRSFaKBlzPAYyto5tXZTNkRLJCH5?=
 =?us-ascii?Q?7boy9ZkiGygzpHagyI/bMDkA5PAjxSX67AAVo7X2RXlY4q8VBpc/OL4aVqi8?=
 =?us-ascii?Q?VcTKBYmo/v4DuPNPDvBm73QPbNwWHHXZNzMogkFProSO+GK478KXJDmm4ZIy?=
 =?us-ascii?Q?k9k12hbAyf+A14wo8X4gb54Zliu5eZm816jLEwIpJFrM1k6jwEgrnCXEp0pr?=
 =?us-ascii?Q?EMt2CPuAIUKp/2bl5JvGGQlz3MwrfISuanqXwbzJBZYOwc36CXgDXWkSImql?=
 =?us-ascii?Q?x/nWaGiCcQp74DYXagv0sxxU3tSGALiC5d8cAQBPleE1BCI/rfNabpv70a1B?=
 =?us-ascii?Q?Avepcso7K645b7FyNVc1OWkAwULqXAxWnuWknOKnXXEZweZP1/RW+BMj50DD?=
 =?us-ascii?Q?1HcuodD8xs2QzAOD25P0gWnv2FrduiGt+sFDOQIABzKl905YAXM7ESm1XJZh?=
 =?us-ascii?Q?Sl0HZyd8wJng0KXZl5vQIodXXoNaF/cZPdtaqDynYaC8h9mDOutdckBMIsFV?=
 =?us-ascii?Q?UKVA4wr8ahbW+rL6A06tHdJGnDHZv63r3uhv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8126.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ql9jpFRVyG9xcb9MZPKDE30Om+BmuEzmZhvgoVTqwwV2PvDIPVqLB4BYqvSD?=
 =?us-ascii?Q?ieni+oY++WCExySkwxmPn/GQaugolpIHw2YqaenLvNBCr7/0tx8nDPIflKVW?=
 =?us-ascii?Q?UCtrEuLEdyCLxFAusFY6t39TwrTgCDTEWgBCQX25gTM7nfa9E7FlOQlqeN7B?=
 =?us-ascii?Q?P4MM6D/GuHycRw+tlM1zeVXCkCKDXnN7QflLUG3mrtDBalARvZDeL+UPsZi+?=
 =?us-ascii?Q?Q8ldZxmkya1TMqDERBqT2ynNr8L3J4pWbF9aJaepVS6gm32VP74H1nt0X81c?=
 =?us-ascii?Q?F4ixT2HFeVbuzxOK6UdF6AT0rayQhyqKaQed96StWXO359EPEhGT5wH9n9Cg?=
 =?us-ascii?Q?MKslhzbXdDdDkjzoVd/kAmsZQHv31xznipELb7f7f+yHKdIkgFyHEzSScpeP?=
 =?us-ascii?Q?ywvnO6tRJwGAt4N/QqOSTU60ptJHmFP+6+F+IfHjycpeEHJC/ND+hlXI03ay?=
 =?us-ascii?Q?LIS7C1kMMMzjG3/sED9S0r2tIClYm9pzM26EkmlWgsbnrKDKzXsBZu5kqv0Q?=
 =?us-ascii?Q?qq0lJtP1cUImsN+XPhgw0u+RTeccJE4u94ARGD+MlzCDVg1TUUFLppmCO/Ur?=
 =?us-ascii?Q?g2n/9Ob+sU1dITCQ8Te5ARWHkJ9GwQRCV1NHhLJM3+OisO89+UQIFQtXpRot?=
 =?us-ascii?Q?ue+w3xCYKniDAnKmo8EEWm/W4rqtyw0eea/YZm7eI/tFbxjAb2Xs7UA0tyFw?=
 =?us-ascii?Q?rP5onhmEg9udCb3lFJjArsVXFlo6YW7Dw4iRjWb0XJ2jdxdmUWAwP5Yvrod6?=
 =?us-ascii?Q?jcdaXntMu91Ln8TlkuuxB3W+G7dIbIGVTgZIsR8A2iRyCs/9/OebCaXFt+pC?=
 =?us-ascii?Q?EPQjc4rGMMbJZxXhRnRXIzb8mMSKGOzo1zF5YHCYQSxtB8HKuiZvAZPkkmmk?=
 =?us-ascii?Q?CfsOqZBk5wa23cUzRygHTKrvHrE9AgQCu6uNCy2Umr7rsxB7kSxTTntLzTEo?=
 =?us-ascii?Q?K2XgbHCCQuqQ5wHKz6H2mGPI9/xLDIX4n+3AKz6kCohyav3znIOcvommvf2s?=
 =?us-ascii?Q?S6EQrZUJgC/GC70ERGci6wOzBOGrGingaIHZcCe4BQMnUGOUFL3l/iO9jwfk?=
 =?us-ascii?Q?h4Z80x7+I4htxGmurzW8bCxmpLujgqlspsFynbdNzKBCLIpzbpyy3zT3saiK?=
 =?us-ascii?Q?q9lhXGbs8Rgys+kLDRC9hq3fPANl/kecBOO37JiF0zeH5SgEc12NRXntLYLh?=
 =?us-ascii?Q?54A2Dge7NF3i7fEDTl37rLg17Vn/ehVNLHlB8E79SW7fOD4UT1420G2wPWsp?=
 =?us-ascii?Q?C5cCSc/VE0QBFdz3gOr4pN5eeK590ToSZt7a1GVB7BH6jVftugDSsd7Tt9wi?=
 =?us-ascii?Q?KyNtlrAmpVrsVJfFPg4C209JjArwjDDYY5pm99Bfi4BB29MF1o4DZTwc7fUZ?=
 =?us-ascii?Q?Q3rBKvczM4LbSGX7eLJz67tvFO6ORO6bMEzSHMV7IWa6kqDkDCZZ/4kuNHcU?=
 =?us-ascii?Q?FmNy/qL+sWSrOZJfwzitTUZaImbjaI6K1nR/4IqQSbX0MuYer9NrmCLj6JIJ?=
 =?us-ascii?Q?OM+A4jYfdfqnRcZ23NB5WSL68nsL2wEEaq30Tb6ujdBuwQnEN9B/o0qBOFNl?=
 =?us-ascii?Q?IW9Tqzg9u0PWj5Dpw5s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c012deca-6835-4bb6-e57e-08de38aa0ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 11:40:11.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJVNIAk+g/s5+QSLjNqVHlYrcGw9pwRLROMQTQ/8Uy3ohbn0npohshrxZqeQwhEGh60J0Ss77J4a/v+NvnECJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, December 10, 2025 10:02 PM
> To: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Verma, Devendra <Devendra.Verma@amd.com>; bhelgaas@google.com;
> vkoul@kernel.org; dmaengine@vger.kernel.org; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB
> Endpoint Support
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Dec 10, 2025 at 10:26:38PM +0900, Manivannan Sadhasivam wrote:
> > On Wed, Dec 10, 2025 at 11:40:04AM +0000, Verma, Devendra wrote:
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <mani@kernel.org> On Fri, Nov 21,
> 2025
> > > > at 05:04:54PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB PCIe endpoint support. For AMD specific support added
> > > > > the following
> > > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > > >   - AMD MDB specific driver data
> > > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > > >     base address.
>
> > > > > +/* Synopsys */
> > > > >  #define DW_PCIE_VSEC_DMA_ID                  0x6
>
> > > > > +/* AMD MDB (Xilinx) specific defines */
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
>
> > > > > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>
> > > > > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the
> > > > > + purpose
> > > >
> > > > Same or different?
> > >
> > > It is the same capability for which Synosys and AMD (Xilinx) share
> > > the common value.
> >
> > This is confusing. You are searching for either DW_PCIE_VSEC_DMA_ID or
> > DW_PCIE_XILINX_MDB_VSEC_DMA_ID below, which means that the VSEC
> IDs
> > are different.
>
> This is perennially confusing.
>
> Since this is a "Vendor-Specific" (not a "Designated Vendor-Specific")
> capability, we must search for the per-vendor VSEC ID, i.e.,
> DW_PCIE_VSEC_DMA_ID for PCI_VENDOR_ID_SYNOPSYS devices or
> DW_PCIE_XILINX_MDB_VSEC_DMA_ID for PCI_VENDOR_ID_XILINX devices.
>
> The fact that DW_PCIE_VSEC_DMA_ID =3D=3D
> DW_PCIE_XILINX_MDB_VSEC_DMA_ID is a coincidence and is not relevant to
> the code.  The comment that "Synopsys and AMD (Xilinx) use the same VSEC
> ID for the purpose"
> should be removed because it adds confusion and the code doesn't rely on
> that.
>
> However, the subsequent code DOES rely on the fact that the Synopsys and
> the Xilinx VSECs have the same *registers* at the same offsets:
>
>         pci_read_config_dword(pdev, vsec + 0x8, &val);
>         map =3D FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
>         pdata->rg.bar =3D FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
>
>         pci_read_config_dword(pdev, vsec + 0xc, &val);
>         pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
>                                  FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
>         pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
>                                  FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
>
>         pci_read_config_dword(pdev, vsec + 0x14, &val);
>         off =3D val;
>
>         pci_read_config_dword(pdev, vsec + 0x10, &val);
>
> The VSEC ID *values* are not relevant, but the fact that the registers in=
 the
> Synopsys and the Xilinx capabilities are identical *is* important and not
> obvious, so if you share the code that reads those registers, there shoul=
d be a
> comment about that.
>
> The normal way to use VSEC is to look for a capability for a single vendo=
r and
> interpret it using code for that specific vendor.  I think I would split =
this into
> separate dw_edma_pcie_get_synopsys_dma_data()
> and dw_edma_pcie_get_xilinx_dma_data() functions to make it obvious that
> these are indeed controlled by different vendors, e.g.,
>
>   dw_edma_pcie_get_synopsys_dma_data()
>   {
>     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
>                                     DW_PCIE_VSEC_DMA_ID);
>     if (!vsec)
>       return;
>
>     pci_read_config_dword(pdev, vsec + 0x8, &val);
>     ...
>   }
>
>   dw_edma_pcie_get_xilinx_dma_data()
>   {
>     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>     if (!vsec)
>       return;
>
>     pci_read_config_dword(pdev, vsec + 0x8, &val);
>     ...
>
>     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_MDB_VSEC_ID);
>     if (!vsec)
>       return;
>     ...
>   }
>
> It's safe to call both of them for all devices like this:
>
>   dw_edma_pcie_probe
>   {
>     ...
>     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
>     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
>     ...
>   }
>
> Most of the code in dw_edma_pcie_get_synopsys_dma_data() would be
> duplicated, but that's OK and acknowledges the fact that Synopsys and Xil=
inx
> can evolve that VSEC independently.
>
> Bjorn

I guess, with some code duplication and separation of functionality for dif=
ferent
vendors shall be OK to reduce the confusion otherwise; we are going in circ=
les with
this particular piece of code.
Thanks for the suggestion, in the next review will update the code.

Regards,
Devendra

