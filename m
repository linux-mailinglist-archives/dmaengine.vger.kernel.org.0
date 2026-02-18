Return-Path: <dmaengine+bounces-8958-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLZlHXKjlWmaSwIAu9opvQ
	(envelope-from <dmaengine+bounces-8958-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 12:33:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7733155E9C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C88073026884
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23C2367B5;
	Wed, 18 Feb 2026 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YtkGb3a8"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3911DFF7;
	Wed, 18 Feb 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414382; cv=fail; b=TNewGTeBKZtJjlO5AU8qAPOZsBAtBlz58KoHJ+oLehz0vOV6Z3c92SpUpwx41wiZQIDEqNkS4bSUogD4eM0ytg7757NGsmFIsqkEk0c9MOF7c/GzYDen50Q9C1MXBYWkF+Rr3j9PqUrPSxivV+ZY5uMv3Y1eibQleMrRRDtVFs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414382; c=relaxed/simple;
	bh=W20+zKkQzfOlTU1Wg7uKQK1dr7o0B+8gRAjISZCGoN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DsqABrjcoO5/JsilTzA/BIatLzdPc9Dx1xl4wI6/PXSBx240iLeZ8ip8kM+pPdLIVhAD7HDVXUam+qY9xQEDtq/GzzZzyHOqy/gR5xFNJVAwj5nPNLIFzpWKgesMK5Uc9rnNDKhV/u+GSbD5o2Me/OeoixrnHIouH9fpxjrlp9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YtkGb3a8; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsMztGpI2Bd7JqbebyypU66E2dlUjJv/5aAJFUan1FBnnqCTWPL8UCGWyC3Nv5GNAz1C+y3r51Fidh+6nqhWX6JrvgSHmfgoGvNBqUoJy41pxNg8U20VadehSAv38ci+2U3DvgRV2pm7QCaj5lNkhAvOBRpNZipTxZ3HsHOatQqOT57QpWQwFfrYy7O/BY2heYnU6dWLqZs/723hVSne3fd/z8SNjqIoSExamhnOgPEwDKDYfHMILA//xU/bCyWXumlWR4P/6aBdwUV0RZpRmWQPwrjRvG2IlXyzYW3l/bkYqIvnlQtO4uiyTm5rSO5fpfSenVqKYpXVFqog7MI+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qEEnIgWJXi4BGfNkSzuhkPPN2DAlpux6hc65lMLfDI=;
 b=q6/MZQvEg4iuTBOFKqpMwyrS2w3EXbJbhqfe2J6Zkk0nQcl8I0J07gfOiVqJ4Ov7uc139/TpWT+pEG/uOgd5y3UQ+JxhhfZ96N5grKsYSvVQyH7lbNBRSP3XxaXjsYlOoNoGEKaT9DmE5jr2YgxASKYny4dN6PYB0Fi7H43whXir7hVk4lQmtsCBAuD09VvFxz0ECJysQMd/YNKACM3CPNFRuweNzwtB8HS22o0Tmptm56MlmHD0l6C5ZOcxgrXKDLGJ1yf0272etxFBaUZHXLmhcIFmsXhbAgumArK42B+yMqfr+tb/LUJ0Uq5SZI2rRZ3l3JeqRmiZJfaD9BTweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qEEnIgWJXi4BGfNkSzuhkPPN2DAlpux6hc65lMLfDI=;
 b=YtkGb3a8Yi2Z8RRztZkxJULB+ro/f/cizNqLAZCbQxrJlVvv7LelV1O4w7gB++mBrgRPwg1wbrpGQR/r7vJc5VLlSq77J4LlMRmiWmKwXBd67Z+ZmRDPK1pJ4R/38NhIrt3EGx1cQ6ZkfPPnnKX6qcQRg0T6hNJf//yQoRNmub0=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 11:32:57 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 11:32:57 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcnzLWCO8+PlOBsUyeigW/SoG/H7WFuzkAgACmYXCAALfggIABEsjw
Date: Wed, 18 Feb 2026 11:32:57 +0000
Message-ID:
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
In-Reply-To: <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-18T09:02:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SN7PR12MB7835:EE_
x-ms-office365-filtering-correlation-id: 5f4e3e96-f559-4bb0-b550-08de6ee176a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0ORiicwvzEg1fjMxLLAdoXOhAZUHwwO9Ws/zy1KIUUsuLv0eODSBLnUYSaWz?=
 =?us-ascii?Q?b+pOB+lbIczBCuwd4mPu8rNI3J3D/RUXwTvIZTIK7/vzvnGf9SISnBRuoBQ2?=
 =?us-ascii?Q?KijwKEDGFTiAbtj9Nhyr513eWFyqhTIporjFIknEJZXJmjPKh/ChgX1lWt05?=
 =?us-ascii?Q?SwW496EEcU5Pkdh043kBExTwAUgE/qoH47An+UifkITwiYAdkNc+Ztysd4wo?=
 =?us-ascii?Q?5N6vTunNug5mt6pAjyAlyicUcnJWkuXeaDCbmsVneVpmQrK6tl4g+Q/ebGgN?=
 =?us-ascii?Q?jJs/aeOTgSzLZ4Ge5m3lpbHt6VMd49xI7RtJQREISqsEfpzy1dGmI9FUmZE6?=
 =?us-ascii?Q?ljajHkCbl91WqBfpZt1Tz+swtnjXy6Mn0+JHwUi9VVyxfxtRJk0rPoAXd51s?=
 =?us-ascii?Q?8qFxdt+kPp1piMlocZU5pV4NiqURnDFNqi+ANwi6tGRVxVZWcfgqcWn+/V7x?=
 =?us-ascii?Q?z7SMdhFIGx1m3kscmT/45uSXk3fylwMuMdt1fhFZg4638+iLeWgqxETYynio?=
 =?us-ascii?Q?ycjwmqiizJdYR3D4u0nwyDo+GjZaGDaEuMaBRSyyewTLcYWZXXeEDP19oPsT?=
 =?us-ascii?Q?Refzjzo3OA6OAa9WTBmdZxswja9kCAkojZDtYkrz5wZC/xoPzZ0JfBtyTm0P?=
 =?us-ascii?Q?n8p9xT5G5s6QGrJg9Mf8ef7R53ippQj224jj7lnqt4TZff0rLZpxp0YzPuOZ?=
 =?us-ascii?Q?QqzO/X25HTF0m2DFkDGASuyWxyxAZtQ61ZtZkkRmhJj44rDW76yj07vdpVCK?=
 =?us-ascii?Q?YCeOrljxkqC0kiY/PznJN/3Jys7b7JoV1Sgl0qSVGaNNHKbjXQt4RtHS5BLV?=
 =?us-ascii?Q?uIcXY5K4powXNaJcUf3w6UmhilXhWS3zeHqpaJtlFSeBOmxdCElCcWweGJCS?=
 =?us-ascii?Q?Vn7eotlTvYKsWV/wBSMJSbdrUTEDW9wzHgECpGsVM01VFmxCy9RQgV9d9dki?=
 =?us-ascii?Q?pmqXvXpNdy0EbDBNnsAqSvDwyc/rUZKY+SWywApRoZ2ufijiFi2+5M9/gwne?=
 =?us-ascii?Q?FFfr936GFgKqyEkbHZ0X3DUImEXFaXFV077eNQfMO0t5iPar0KEDKRX8BrwG?=
 =?us-ascii?Q?NwUyQV0yRSr+mQzI79ypRHTn17seuqorYHrz9r0ndsUZ2TbulqbiZvO6x/7U?=
 =?us-ascii?Q?T2pkTq3utCRnRJRuHDUMwqVujYdrJweKgMdVLakLaxhGFW519WY4GZDAsqm+?=
 =?us-ascii?Q?mCh7WmzWbhpcJMzOo8SKue13wCx1fkZ+Zo1IQVFmv6MGEMHjn3aUXTP+YGrz?=
 =?us-ascii?Q?Q3KHpPJe1cjKroIp/YvGxnj1SmvbdQgHSovULKrHdtIE2pviM/sUXtNPFtiX?=
 =?us-ascii?Q?3kHq68GZXl5dhS0imm86xU2RziSzrZZSfDyxUlAKZH7atKxaC+Oy3sN02p1O?=
 =?us-ascii?Q?hDvu1xC3KKvRet+bIBRDi0QTTBRdGlznqw+5BsZDHWlLtfAS2pYgChls7vZv?=
 =?us-ascii?Q?TnyRuzqJT+rkJQN746virXYHSa11GG2sg44lekQnBfWhatR0XVF+gK7027VW?=
 =?us-ascii?Q?7N9ML3YjyAdhs88GHRSgJDC6MRqNaZGtMuM+XGjIeKgjIkGZeLagLbADDLVt?=
 =?us-ascii?Q?ULyH7hBNtji6iRzvA4xX+0n5bWfZVUlPF870xHJ7ZW7Hxx1PioXepk6zcu+J?=
 =?us-ascii?Q?pAsQfaLhOcuspqBbolEVTCQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9LNt2C30r6X+AcGC5E2YKuDLqZPVosY/xb6H0RA/Mafjwm6n6zXipnYTmvRI?=
 =?us-ascii?Q?o7rCEBrPoLpIumZjgmcPC+E18YMENyZN4Ubh6J7WJ3tK/2ijpJvvd10PtKjb?=
 =?us-ascii?Q?e7L+pItIisSs9ptQOjfXNMdaHgfP0ZmRA9nAOHnX5i9usgC/+Y5NOeHiS1QI?=
 =?us-ascii?Q?U9ycTw3giOcVWjQ+NXjZeNxwAvAkZE3jfoi6LvlIyd+owR1JWqMwABcIVy09?=
 =?us-ascii?Q?rSqMfbWhi3O86fpo4pL0ocMUK/bRIEKK9LFqlfY/7zppALBy4hyMCcZouOmL?=
 =?us-ascii?Q?moZpbd160M5YbQFe3X4QzucXco3HgWikiR6fhUU9UJn+5/cgdGhH2u/AGvg2?=
 =?us-ascii?Q?ykUKu4mK52yVswsG8z1VusB81KTr4ed7b3MPQZqzismNU2eyShVO0n9D7WGd?=
 =?us-ascii?Q?Ir73f2G7nYoWoCtFDTuZdK3+ZRgYBQIP1zSFagX9aS8R40L2IDqYJh7lsKPt?=
 =?us-ascii?Q?p+5njwmfC+0TuenXyjb3U0ReGYSG9dcwWX+VMhXE+23d5Yg5Y3R+Q24bIov6?=
 =?us-ascii?Q?pJI+/+18RKeSLTay3LMnRIyK6fc3c5HmoOtb+waCjrWa6ERD6lFkKAAPV9AJ?=
 =?us-ascii?Q?9ZKeQErF2pG/RnirrYsK7DBYg7pOj9LnLd1fT5FeKe2T+rz90lnP6HpdiaGO?=
 =?us-ascii?Q?tRavVLA+YTnZgY5g+COhzoddSVQ8y9kpCgZlKm5AV+eAKbAbHVlR7NanksqU?=
 =?us-ascii?Q?opxhhbCxFbWBlnqb7P33TpG9Zy11zPnQfETg9zJgd903z1h8IBjNkak1IuBf?=
 =?us-ascii?Q?oTcZHYbRZJv5cg0mSJ363XqbW3P2TH0LuMTrNUrjZjgwTh9f4FgLW/pONfuA?=
 =?us-ascii?Q?H6WP7q4YMgg0sO/FcPtsTR6DTwdhZI7f+gSJU8ssKKue8OekbxfiQx4T6gMY?=
 =?us-ascii?Q?1QbZof+bhPuZCB6dnttqND743gyl85P68nr8gdkWgVT+14STBIdJiCVPultb?=
 =?us-ascii?Q?WJ/+PmJ2/F4yfJF5L84j3REDVRWMRUWpM0DAyToz5zuxMrHtPyDm0Wafaq9i?=
 =?us-ascii?Q?sOsX5bX5Fez/FFI1IisAziVjkncNEE3OP+N//53JMYUxgrXUqm96uAvpmc+8?=
 =?us-ascii?Q?ea9AdCWvVmrfz/AH0kqGE02VPLeoUd7JrjPMyXHIgBE4EqHgq4cLATkNkCJq?=
 =?us-ascii?Q?HsDasXyuSG43gQorS/9ptL48CxDDpQXLoNAmYYCwwu7yrf4V1j5K2Dqaq3s5?=
 =?us-ascii?Q?ryLWJl0vvJvRMybwWyiyO5073i+8o56rGWAJlzMe1tB27Trtfo+Oj80CWgsk?=
 =?us-ascii?Q?2FOtr+iXcgF8Kito2P4n6VQlOpZ6uU7e4eX1IYDWAgXdoQFp3URyJez6mjTl?=
 =?us-ascii?Q?5HEu2txuwf3m8/zY1fA1f+dYOwVMY7PpqVHwLCMBd7SJN9xNDq5YqPCJ/JiT?=
 =?us-ascii?Q?LemIoUOa26P5GJ0Da6ZBxG4JYE03rqwA0fa2PBWDzYDPet09h+xh+Z/KfDuf?=
 =?us-ascii?Q?jqmlOWAIebjDoIbxY9mrnjiwy5/YMJHCsj5hnvhUpmhoA/YIH6idOWHkxsAB?=
 =?us-ascii?Q?wrLChWqJR0y+s74fh9ihP+atvwofNdZwEYY1CFDiABIcJJuFMCimX89beBm1?=
 =?us-ascii?Q?JbJ50Z188nrBW+QXCF8V5VLnsO+rS1issQh1A9zUKenkX9bLRlOprj4DUJzl?=
 =?us-ascii?Q?w9kPCXlzBZlqVZK+XFVzHfN2nhBpfJp93JEP3YGGSYtfqS7I5YFHo+6RFIJG?=
 =?us-ascii?Q?GZ11tY6LSjnq3OPiPTpZFocey86Xfg1v+k13d472n2lxmzXq?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e3e96-f559-4bb0-b550-08de6ee176a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 11:32:57.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W56ARkr5r6Mmq1n7VNLbF3div63SsnUbBqj8DRb6w2t8Dwc4jCATkH4Rcdfi+fqqautU2qdFbPO1tAc5Y7i5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8958-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E7733155E9C
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Tuesday, February 17, 2026 10:09 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> mode

---[ Snipped some text to reduce mail size ]---

> > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the DMA
> > > > transactions using the non-LL mode. The following two cases are
> > > > added with this patch:
> > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > >   the device side DDR is not configured, then the IP can still be
> > > >   used in non-LL mode. For all the channels DMA transactions will
> > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > >   is not applicable for Synopsys IP with the current code addition.
> > > >
> > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys=
,
> > > >   and if user wants to use non-LL mode then user can do so via
> > > >   configuring the peripheral_config param of dma_slave_config.
> > > >
> > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > ---
> > > > Changes in v10
> > > >   Added the peripheral_config check only for HDMA IP in
> > > >   dw_edma_device_config().
> > > >   Replaced the loop with single entry retrieval for non-LL
> > > >   mode.
> > > >   Addressed review comments and handled the burst allocation
> > > >   by defining 'bursts_max' as per suggestions.
> > > >
> > > > Changes in v9
> > > >   Fixed compilation errors related to macro name mismatch.
> > > >
> > > > Changes in v8
> > > >   Cosmetic change related to comment and code.
> > > >
> > > > Changes in v7
> > > >   No change
> > > >
> > > > Changes in v6
> > > >   Gave definition to bits used for channel configuration.
> > > >   Removed the comment related to doorbell.
> > > >
> > > > Changes in v5
> > > >   Variable name 'nollp' changed to 'non_ll'.
> > > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > > >   Comments follow the 80-column guideline.
> > > >
> > > > Changes in v4
> > > >   No change
> > > >
> > > > Changes in v3
> > > >   No change
> > > >
> > > > Changes in v2
> > > >   Reverted the function return type to u64 for
> > > >   dw_edma_get_phys_addr().
> > > >
> > > > Changes in v1
> > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > >   Corrected the typo raised in review.
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-hdma-v0-
> > > regs.h |  1 +
> > > >  include/linux/dma/edma.h              |  1 +
> > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -223,6 +223,31 @@ static int dw_edma_device_config(struct
> > > dma_chan *dchan,
> > > >                                struct dma_slave_config *config)  {
> > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > +     int non_ll =3D 0;
> > > > +
> > > > +     chan->non_ll =3D false;
> > > > +     if (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
> > >
> > > Need handle EMDA case. if mf is EDMA, need return error when
> > > config->peripheral_config is not NULL. Or remove above check to make
> > > code work for both EDMA or HDMA.
> > >
> >
> > For the case of EDMA, the behavior is unchanged.
> > Even if the config->peripheral_config param is set then it would be sim=
ply
> ignored.
> > This is retention of the previous behavior. This is done because
> > device_slave_config has other params which affect the behavior of the
> > DMA transactions, we do not check all those params and return any
> > error. The error is returned only in the cases where particular
> > parameter from dma_slave_config is used and if the parameter is not as
> > expected or in the expected form. The parameter used from
> > dma_slave_config for the particular IP type need to be known first then=
 it
> can be checked for its correctness. This is behavior for the peripheral_c=
onfig
> which is used for HDMA and thus error checked.
>
> It actaully hidden error. Your patch provide an option, which need't ll m=
emory
> to do DMA transfer. DMA consumer actaully don't know which backend used,
> which is private information by DMA engine providor.
>
> dw-edma-pcie.c is only one of all edma users, which know DMA engine's
> information because it creates this interface.
>
> PCIE-EP framework also create dmaegine, PCIE-EP function driver use DMA
> standard interface to get dma-chan.
>
> if (config->peripheral_config) { /* only your specific dma consumer set i=
t now
> */
>         /* optional config information */
>         if (chan->dw->chip->mf !=3D EDMA_MF_HDMA_NATIVE) {
>                 dev_err("edma have not implmentent no-lll mode\n")
>                 return -EINVAL
>         }
>
>         ...
> }
>
> Add EDMA support no-ll mode is quite easily in future.
>

This looks reasonable provided that HDMA got the support for this param.
An error check can be added in the next revision.
The addition may be slightly different as following:
If (chan->dw->chip->mf =3D=3D EDMA_MF_HDMA_NATIVE) {
...
} else if (config->peripheral_config) {
 /* error handling */
}

Using the above, if support needs to be added to EDMA then a check for corr=
ect 'mf'
in the if() shall be sufficient.

> >
> > > > +             if (config->peripheral_config &&
> > > > +                 config->peripheral_size !=3D sizeof(int)) {
> > > > +                     dev_err(dchan->device->dev,
> > > > +                             "config param peripheral size mismatc=
h\n");
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +
> > > > +             /*
> > > > +              * When there is no valid LLP base address available =
then the
> > > > +              * default DMA ops will use the non-LL mode.
> > > > +              *
> > > > +              * Cases where LL mode is enabled and client wants to=
 use the
> > > > +              * non-LL mode then also client can do so via providi=
ng the
> > > > +              * peripheral_config param.
> > > > +              */
> > > > +             if (config->peripheral_config)
> > > > +                     non_ll =3D *(int *)config->peripheral_config;
> > > > +
> > > > +             if (chan->dw->chip->non_ll ||
> > > > + (!chan->dw->chip->non_ll && non_ll))
> > >
> > > if chan->dw->chip->non_ll is true, It should return error if you set
> > > non_ll false because no LLP base available.
> > >
> >
> > In case the 'chan->dw->chip->non_ll' is true, then the default mode
> > becomes non-LL for HDMA ONLY. There is no option to the user to
> > configure the LL mode by giving 'non_ll =3D false' as part of the confi=
g-
> >peripheral_config.
>
> This is API's callback, you can't assume caller do all correct things.
>
> > The configuration of default non-LL mode depends on how the IP is
> > programmed by the user. The user is aware of the IP configuration.
>
> It is not true. DMA consumer don't know such detail information, which on=
ly
> know which dma engineer providor.
>

For the DMA consumer the only option is LL mode as default mode. In order t=
o
use the non-LL mode it need to provide the parameter in the form of periphe=
ral_config.
Given the above statement, the consumer even if gives the 'non_ll =3D false=
', it is not going
to change any behavior.
Even if the user is not giving the option the assumption is that controller=
 is in LL mode,
unless the DMA engine provider provides the information regarding non-LL mo=
de as default mode
to the DMA consumer explicitly.
In the case where chan->dw->chip->non_ll =3D true, following case may happe=
n:
- DMA consumer provides no peripheral_config param or simply config->periph=
eral_config =3D NULL,
   in this case non_ll =3D false which is the current flow.
- DMA consumer provides a valid peripheral_config (!=3D NULL) param but the=
 value is '0', in this case
  It is explicit but it would have the same effect as above case.

DMA consumer is supposed to provide the only option non_ll as it was not av=
ailable and LL mode
is set as default for the DMA operations.
When 'chan->dw->chip->non_ll =3D true' then this was added to make the chip=
 usable when
the LLP base addresses are not configured. Without this, user cannot use an=
y of the modes
be it LL or non-LL if the LLP base address is not configured.

> > The check for non-LL option
> > provided by the user is useful when LL-mode is default. That is why
> > the value of non_ll =3D=3D false is not even evaluated.
> >
> > > > +                     chan->non_ll =3D true;
> > > > +     }
> > > >
> ...
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index 3080747689f6..78ce31b049ae 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > >       enum dw_edma_map_format mf;
> > > >
> > > >       struct dw_edma          *dw;
> > > > +     bool                    non_ll;
> > >
> > > Can you check ll_region directly? it should be equal to (ll_region->s=
z =3D=3D 0)
> ?
>
> Do you miss this questin?
>
> Frank
>

Yes, looks like I missed this question. Could you explain a little bit more=
? I am unable to understand the context.

> > >
> > > Frank
> > > >  };
> > > >
> > > >  /* Export to the platform drivers */
> > > > --
> > > > 2.43.0
> > > >

