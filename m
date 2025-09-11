Return-Path: <dmaengine+bounces-6447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE8B53138
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C935A47E0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB14320A3D;
	Thu, 11 Sep 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TghJTYck"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8831CA65;
	Thu, 11 Sep 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590956; cv=fail; b=fUMPuP5rQnj5LdyAUP844IsWuyFYzYpHHxFklw7IPav7v78pebja6uxtt7T4vUzYFJ/Aaw6IEo7FFq5okPmcZfRUJILlUJoNbktgqJ43GgJcadMQPLPBjr65L2n3FhvGLby4qvl8//FLCl9mhgQTdMKtXNHQWzuVFjk0NrZcv2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590956; c=relaxed/simple;
	bh=g2m4AeqaTI+1rW9r4oyyndyOorB2IaCTGjBHOxhRJyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4HZB7qeNSN+MxkfI1Hyv4JG42LbmnZM+X8lCNysSOfO2HHa5nC+ihAKcxdKfqHWmgoq8JRGLdihxz/wuozo444cSryXv5fWy3oroFvBA7KCkAs4vkoGHoa7ChhkO7TEhcNqwbYnq9o2XLr/VF62fKUZOS9XbYFS8vt0+wW8y5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TghJTYck; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN/eM86hcTsXPxVbtucPGUEmzwaklkaRPqxa6/d6oSO3bJ8ZkKJaM/rG66fQf+t1NgbjcyC27x2ycZgvIugZnhJB89AQVNAZI4Pi+W3BSI9UoiFYzA9uTC24gF4BWz2MyI+s0h1BNByHgPVWRlICpYU6YL5HuW00Ipxvwr7o+TvNu/EsGl3MFADe1CUaIpG12/hXlztBc7AHq2sgIEfC4dt98/KVizHxI/u69xK3I70P2k1STNE6QuY6d4zaKE1xlEj7n8ZEOmF5PMsIG9/umBAfBqoLegX6c8NpAqDq1v4+xplqUJr6cCyNV6NyRQLbVfa7sHj1oDxpxvyjGGxhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhucEQtWg0FVacbq77khaXJlJfCsVlguEtZNPLq6ipM=;
 b=yzdStUoTtE2yiF8yoVVkqYYcQkKnDVHcjG+9zaDi5+nUH3NVyq5vi2IrNyG/oBBh7gqWul+tt+auSE+o1LuZTcvb0doQ/Mf1fszMelmS2C4vMbQeik2NQuZPosZSpcEi2mCOG5v0iGOl6yWYHOgtn6qihDA+WlvxlTA/Ajha3cugo75/ywpBJDIfIf6Ccc+Ql+81qikdPATz/GiS0mdJoUQ+NOlcCq6Bnkjdk2GdZtXv0ZYW9bsxvAhDy+wqfwl53L8e0+cYENHGJWTxCjHsShAH9pCT9GnKsyq4pbji6aqgeKsrq0hf78uZtby0245oUHbzWojbQ4/cizykBkNIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhucEQtWg0FVacbq77khaXJlJfCsVlguEtZNPLq6ipM=;
 b=TghJTYckCka67Xmft3jAsBeOwT2Cy4fOwBuK/8Yxx/kVFj1CXon/6JmQMIRVzrx9Cs6CDu35f433sWrOH6/7JPDoVvR9JgCSpFthWIKBeHcEv+UZYuEUBe3qGwb66iN5xEvOs1wm/3rkDdE6SWj2uWD5jJ7h6+3BzhUFtRo0WPI=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:42:32 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 11:42:32 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcHpgus9635/jJ7UqyWh/j4Mmvg7SMBtGwgAC0f4CAANbYYA==
Date: Thu, 11 Sep 2025 11:42:31 +0000
Message-ID:
 <SA1PR12MB812027AB20BEE7C28F30A5FE9509A@SA1PR12MB8120.namprd12.prod.outlook.com>
References:
 <SA1PR12MB81200F594C9B842C563F3DFE950EA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <20250910175637.GA1541229@bhelgaas>
In-Reply-To: <20250910175637.GA1541229@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-11T06:45:34.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|MN0PR12MB5762:EE_
x-ms-office365-filtering-correlation-id: 673f407c-73b5-4e77-f655-08ddf1284b53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mQhoDhT1PAIuE/psS0v42Ja62Ws6pPJocwCDJj/C6SxrKLZjQQiZEF+utnjd?=
 =?us-ascii?Q?myozTtAZx20/cwY2ZmCIdTn/Iq42LRx9hiYFLtQrxBB9BwhPB1WjvWH5rc6G?=
 =?us-ascii?Q?D6AcsfHVk4eb9HAVl4Mcs9U9uVXhrVOHJ+CXc7kYiOc4uwDsCoLbgd2/2eBI?=
 =?us-ascii?Q?0o0NxIzekoC2XShusoSXGq2ivEh4AbGATXeYsGv950mkeErXV9l1ZMne1MqF?=
 =?us-ascii?Q?mPO3doBT6uXhOTx+9Fw0kIrkKp57HEvsQMwI4CXWkadNk+ncPL9XPJpdUr1d?=
 =?us-ascii?Q?uAKF09197tLLQcC0qBX8+9hRoqmuZI1aNPrUEdwJp3+sjVjvBRav6xaw+yE+?=
 =?us-ascii?Q?lHytAawnMdSBTIoHAdiWzhrRWDSd891b1TVcKj6ep2qX4zP0cgE3bAgr9ZU8?=
 =?us-ascii?Q?cwZVZtTd+30TIFHChqpxJTUREwPxtRW813Wm1HnQTZ/YMMRy36bPdDvltdub?=
 =?us-ascii?Q?BBTlkRG+L6uTNERkuytuh7bMIE/HzAmYYdHyDZR2kjQNHlOGORrWQiBEL/1J?=
 =?us-ascii?Q?Nf0es9rxJVc0vEhNEPR+L6LeenBdwQB9nM4F3vIQkY0b9jYq80dA5ZMeOkxy?=
 =?us-ascii?Q?tEZATIX5HIuTWXwXBSYe2oBsK2/C72NRW3UI57mvMctHVLtFKR9Gkez/125J?=
 =?us-ascii?Q?KeMoFFgM2Fvlvi5mpm/KsANikDHDUrZRuvyhQ30sXgDMwq4mu9zFFlCfqVRY?=
 =?us-ascii?Q?EqXzLoKxSQsmqW+GjXFHnzqkdq8Zp+XrshGWiJ8x7bFFKN2BMJOzuF+xnEvS?=
 =?us-ascii?Q?G95cwtbkrbTjnd8RFYKxYh97fP21IC5zKBbVR/uuiCF8dFo/X5nvn82Jz61t?=
 =?us-ascii?Q?gbf9cOywH2aIWOwm4nEdMnc8ZBs6Ew2ogmngW+rf15CbIwZwso73oOtWhGqR?=
 =?us-ascii?Q?+Ob8i7lrIyKGl56VNQVgJdPyX+Z0Rsr6uA75D2RCuAoyvtmUxsSEMjbQmw/2?=
 =?us-ascii?Q?n6TL9vuinfft1CkBasGY7AfKazgCsbldbe7STMCCJJs0xciDOrOgC/ETLIej?=
 =?us-ascii?Q?k7e7/yxJSDUMxBSNTCHhbqsqNNPiog6LOy79Wzn8TLNN6mhFBaiaBQH40/kE?=
 =?us-ascii?Q?2/621PW8k3ELpfFXjSo4pAdc7ud5UdYKpQNFArRv9LPed73gL628jqgHe/z9?=
 =?us-ascii?Q?gEejs3ODuBGE1DD8FSzwgI7PLNK+A1EG2Xt5aCieGYyfoXv3xzQ9AVtbQ9Fe?=
 =?us-ascii?Q?QKp358IQOzkp38eL4rUVYcC4Zpu3lY1NOQBizJLQTIKOeyae3qbToMc/8RSg?=
 =?us-ascii?Q?IBRTBoBaF/HZt7PLS9Y+nMFPpAZ40jxS4NwZf2WB5KMqJwHgF3VL1DoprpOt?=
 =?us-ascii?Q?4YrbixEaWVaWyXxX2mp2G9IdS2U4a85z7xnJ3UAC4t5KkN0dlenTHTggkyd3?=
 =?us-ascii?Q?K74/wiVVDJZfIxrzHjjZtjN6ybizqsyBQrP2VMf34yhnjn1xIYrgRZsiyTNe?=
 =?us-ascii?Q?f46NmgjF9FzQBZCAgVdzstJMTEwkf1+WbALEoFGRJg9LWXCf0IjNdzrn6Ly2?=
 =?us-ascii?Q?jEyNDYi6U6gbKBw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tfg4tf27uGg83GnUZeh1kkIm9ar8+qpTt60iECxaS2uaHFF26BJ9s3Ecrqgu?=
 =?us-ascii?Q?/VZ+BozcEe++C88zjYhfyntMsxZF/YE/oT/bi4gVjwLdAOaMRX4uAhxWCiQZ?=
 =?us-ascii?Q?AaVHPVvjUeCFveAL07GZ2ZWuzvxnx1JtpdnCmqrplu0Q6VhSceezEheyEc0a?=
 =?us-ascii?Q?RQe2LEceXuGOxbtf1t+ErqyTZBS3wKUhkreebtBNPovgS3HWOPAeHXGI6QcF?=
 =?us-ascii?Q?DK9lnNWH1+ztbewh+9FlBjjwbuhWydY0prbbXMsbNBi3R22p4e7xcz8cOKiZ?=
 =?us-ascii?Q?4TvNQUcBNud7usHIQEP1ukyNN6p5rFz7KkegQSNvvHYTDIzD8Y+zyDd5o1fA?=
 =?us-ascii?Q?TfW3eJ+DV4chXRYoBl7IdCyehj4ApWnoTIWRkp+oegmQrL/Jn8gsarhjPg71?=
 =?us-ascii?Q?k6HzCDbGl3Q4NLIKO+Tf29SnQ6Y03fKhzDgTAMR/mcsKKLtoQXuoP5EcyKq4?=
 =?us-ascii?Q?1pPbUP8slE8D7CI/QVw1qGdoklux2TMxfc2xgwgqiXhxQzhsciuKyK9LzdGd?=
 =?us-ascii?Q?jgX+bqRRVQtoQcm/Fxi6ndKBicEYsUSfkTZyYI54M0lvQ9C2f/2mmnrmrFOg?=
 =?us-ascii?Q?LBYMK+IYCfT3c0bNcoc2py+drZf++xr/i+X+bh47hio4rxa7V+EOJMWr2jhB?=
 =?us-ascii?Q?JAMMplgcrXqdPoULGar6nYXffv001JCWjqTo0XtyRQ7CHQ7AL9o48IbB7lgY?=
 =?us-ascii?Q?47HB/fd6ajUJKuS0kkT4qd/WsTls9QaEMJBg2MKXXOLMZd/nQuCvG5xMTzei?=
 =?us-ascii?Q?4XpCarigQIiXa9n/XL3XLv6bwl/HHVTNZN9lSdxzkaoR8sydQ0a+0mCoDsLo?=
 =?us-ascii?Q?PTAYaaz0AA8RqsMofLHIfN9LgKzDrLDnlztLTBgFq+WiIrM6rChOg+x5GUDj?=
 =?us-ascii?Q?XPAemToOTtIye2ogNsHP25F7dT9SJy4j8kNlbXvugGOPn65/YDA6B0tDh6eJ?=
 =?us-ascii?Q?nb0BgmxVw0EXKK5X1vyuw382MAM6htdbcQGGomXG7n1Oin4Crqi2XjqBh6QJ?=
 =?us-ascii?Q?htNvx8EIBhic7xUSC9xVnJ17cDvYzlYOC34goLfznjOmzlFFDVCwhnauscZo?=
 =?us-ascii?Q?J+oGkU0LEOVSweYcs+DuDJR9Z9J+RQ+DFfOfSdy1DvKikBZ79FKAkS/bhIJn?=
 =?us-ascii?Q?DP+FHeNHETsYqkOkWtlNLEtVmaTothtfx35Jb+1Anp3Jwxvze22C9j18P1ki?=
 =?us-ascii?Q?zUcw1zexmgVX8WQPp+4loCvnu6bBMQVzg+neBaKtUHRcHcpPdXyU1hSC1bu0?=
 =?us-ascii?Q?lIuRDqam38qe5ZRmpf3KH68GHR3eiEcX81U2Nv/UF6kOtjssLz9pfELNWc97?=
 =?us-ascii?Q?ljCTfj5naYdJ5JaFr2mQmCKDVx2dqR7+hK+Ht/cpduNMmppzHkN3R3Z3Jtr4?=
 =?us-ascii?Q?EmV4CSreIf0tydqAOL9/PlQTMy/NVPLYj6+bRr/7LSVZyjEJcjKjy43DxoY5?=
 =?us-ascii?Q?lxsVw1ZB2NKATp6UhGUAc9LlYh8YnR2ORjNQ+y75lWmtwuxdZhGR39i4p6s5?=
 =?us-ascii?Q?5ehud2+pC9Zb30lUE+F8JWoKtguZr2sCQDI1R0zsCLQK8wma/sSejSzf9Hyl?=
 =?us-ascii?Q?Xvr0U/UCy33ltkXuQ3E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f407c-73b5-4e77-f655-08ddf1284b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 11:42:32.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teMQIAsjuVrh2vpZHNEl0Smi+RR/tGoNvRPZeSgXSOAjcFF6s/e8NY4bj0MI5Ezq1m6A5r7dzYBR62HJ0PPuFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you Bjorn for your inputs!
Please check my comments inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 10, 2025 23:27
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Sep 10, 2025 at 12:30:39PM +0000, Verma, Devendra wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org>
>
> [redundant headers removed]
>
> > > On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the DMA
> > > > transactions using the non-LL mode. The following two cases are
> > > > added with this patch:
>
> > > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > +                              struct dw_edma_pcie_data *pdata,
> > > > +                              enum pci_barno bar) {
> > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > > +             return pdata->phys_addr;
> > > > +     return pci_bus_address(pdev, bar);
> > >
> > > This doesn't seem right.  pci_bus_address() returns pci_bus_addr_t,
> > > so pdata->phys_addr should also be a pci_bus_addr_t, and the
> > > function should return pci_bus_addr_t.
> > >
> > > A pci_bus_addr_t is not a "phys_addr"; it is an address that is
> > > valid on the PCI side of a PCI host bridge, which may be different
> > > than the CPU physical address on the CPU side of the bridge because
> > > of things like IOMMUs.
> > >
> > > Seems like the struct dw_edma_region.paddr should be renamed to
> > > something like "bus_addr" and made into a pci_bus_addr_t.
> >
> > In case of AMD, it is not an address that is accessible from host via
> > PCI, it is the device side DDR offset of physical address which is not
> > known to host,that is why the VSEC capability is used to let know host
> > of the DDR offset to correctly programming the LLP of DMA controller.
> > Without programming the LLP controller will not know from where to
> > start reading the LL for DMA processing. DMA controller requires the
> > physical address of LL present on its side of DDR.
>
> I guess "device side DDR offset" means this Xilinx device has some DDR in=
ternal to
> the PCI device, and the CPU cannot access it via a BAR?
>

The host can access the DDR internal to the PCI device via BAR, but it invo=
lves
an iATU translation. The host can use the virtual / physical address to acc=
ess that DDR.
The issue is not with the host rather DMA controller which does not underst=
and the
physical address provided by the host, eg, the address returned
by pci_bus_addr(pdev, barno).

> But you need addresses inside that device DDR even though the CPU can't a=
ccess
> it, and the VSEC gives you the base address of the DDR?
>
> This makes me wonder about how dw_edma_region is used elsewhere because
> some of those places seem like they assume the CPU *can* access this area=
.
>
> dw_pcie_edma_ll_alloc() uses dmam_alloc_coherent(), which allocates RAM a=
nd
> gives you a CPU virtual address (ll->vaddr.mem) and a DMA address (ll->pa=
ddr).
> dw_edma_pcie_probe() will later overwrite the
> ll->paddr with the DDR offset based on VSEC.
>
> But it sounds like ll->vaddr.mem is useless for Xilinx devices since the =
CPU can't
> access the DDR?
>
> If the CPU can't use ll->vaddr.mem, what happens in places like
> dw_hdma_v0_write_ll_data() where we access it?
>
> Bjorn

As explained above, the host can access the device side internal DDR via on=
e of
the BARs but involves some translation (iATU) configuration on the device s=
ide.
The issue is with the DMA controller which does not understand the host sid=
e
virt / phys addresses thus need to be programmed correctly to the device si=
de
DDR offset which is a valid physical address on the device side. Host needs=
 the
Information of the device side DDR offset to program the LLP register using=
 which
DMA controller starts reading the DDR on its side.
Hope this clarifies.


