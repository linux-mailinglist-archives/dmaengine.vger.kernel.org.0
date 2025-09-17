Return-Path: <dmaengine+bounces-6599-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D921BB7C7E0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73681C01E17
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 11:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4D369992;
	Wed, 17 Sep 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lc+UMWzk"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24B2D0283;
	Wed, 17 Sep 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110356; cv=fail; b=nSU9/3/hVGbq6JlemoeJFU+JfQaD8yU73DTcOTsnBC6AHcPglJ+6axkeOrUS2Tj0J7UUqTgeP597dYIY3wrZSF7C6PFOcSuE/aJfTILYOQYDpKQMuaC4MfaTLyTQ3F8EUaMw2oY6uWZ3j/8PPE8gj3lXj1MjhOA+iWrHhLGreUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110356; c=relaxed/simple;
	bh=2Xc72jGmgtlLaNUELkfc5wtt5MoUqqangfmPHnghNG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmcRy/BfDSCY9BtQlE+mesyd1G+ylq9/Km3D2pgef7iZzXBQWvS3cUxU9SQUl7YbbSkRIhKWrbf/z8RZsHy2M0CEu9n7W7XuY3ytn+aAMl0MThuYpn285vxW31eZRYmL2a84Qr7WkmydvIPElFSzvx7hDfQWtEMzim0MqiRDbcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lc+UMWzk; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EG1NtBmvY1kIJJeX2+9qTl4e0PsGncIQ3+Nth/UQEghFvMuorwfQts3ssIivxw+vG9eQIwG87QXIP/9GqdIsVI8NTdfbq2XuS9utubJ9sG4RGMbDLYd7Cy4T6JVzr7ylaH1V4PZsrPL4BDvhhG5QFQC6rHtwdExug2p2X5hPE2jez4MTOW2uyVNoKQxTP9EK81w/UiKSlReY44d0th/szciOhsUsQL+fWeiuOg1dgVS8ElzCQkkSUn+SXwtkVn1tDIuaorJD1IfqrVlY25krkfU9CAy35k9WueZLRpLife/yMdi8EXPDILaRhb5/pNzks9ooAlTVVQf5FtCeyUA8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrnfZHoHY5UAB7LIICZWFvp2ft/kuBuCtf8bClb2ZPQ=;
 b=X7SJ220ZzP7BaL0RmoGIaoFKoE2XyXHhbtMUCTmfbkOKg7G5w+/oMdhMsVyP7vpvzA25QGtv5vijRlnSf3hazw8nYQcxAf3JtRkogmEt5291MBgwIvtZUOjnyBA4V3qQNchfBPA1aht1p6eUk092a8T2dM2W5vIocgqcx+oQxNEzUVHAbCb9wD7m/4tUCLy02cptZY5RdiwCc+SsyTtP4JK6dfa83A8I81ImcNkFOoQs2FDTBXShBKHpMSJN5bPZW3Lpv1Oj2lq2ttv8p7FJuC1UpmcxehCf4lYwvUM6/xv26MYCdXkua1szaItV8kapTa/IuhInn0uqQvTmJI8tXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrnfZHoHY5UAB7LIICZWFvp2ft/kuBuCtf8bClb2ZPQ=;
 b=lc+UMWzkV8kw5u+yw1Ce+aTLTBYLA5OrlyaJoFlVD6O9H3HuhkP/Qk2vVz+4ODSeStN7A9JmSFNw1WJzgiNV6R6JUqAy4lo2/eOA0g20DOipN18AhqY+yxHlQ1eqjqwGBSFjVb2gB5TGmu0L7htM3AiblguFZugt06M+0mMyPss=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:59:09 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 11:59:09 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Topic: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Thread-Index: AQHcJxsoxoxxNDmQwEmag7lZInAHGrSXQMhA
Date: Wed, 17 Sep 2025 11:59:09 +0000
Message-ID:
 <SA1PR12MB8120DB05E469F3645F3C18A09517A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250916104320.9473-2-devendra.verma@amd.com>
 <20250916150405.GA1796861@bhelgaas>
In-Reply-To: <20250916150405.GA1796861@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-17T11:37:50.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH8PR12MB6985:EE_
x-ms-office365-filtering-correlation-id: 463f2557-4210-41b3-d282-08ddf5e19c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XcYBZr2IHW10OqGf5P2pDspyZCrEnGFa1uR0SzU7wsxqvferg3einB/CWI9g?=
 =?us-ascii?Q?fsa5phk1pdhA6h6DANoJji4A+gCiRmWCVmAyueWodQCPHUeylzMRYlTgXIxS?=
 =?us-ascii?Q?XBs5kOKJBMumUyGulBNPoVMCp7VRIMrOih/gnNstHycYhJfbzdbIteKFnN3h?=
 =?us-ascii?Q?ThupMYLGPilCeBD8BfAu6+TgCfnIt/UK41FV9GUwrqe2r2xwqF246v2ev82v?=
 =?us-ascii?Q?6VzDpKH/Yx/WNkVC6XO3EpFoBJ7HntL+kal6lVSdJGAN/W+cmucVsoufzD9I?=
 =?us-ascii?Q?4gdu/Ues50XCoU8xlr+hCGF0npjemautIXpQlA1WmpnMzFexmbdg8C2aYMWG?=
 =?us-ascii?Q?5nmSLSxlliiClXZhak88+AiDQsF5C2cQ3zkgSj9BR6YrON50H2AsUw917gsD?=
 =?us-ascii?Q?vI0jMVAbUc6tCbGEZPuC/bXIzqcYd7C7SsgcZVBmYDWu1skbY+SwgW3ew3dj?=
 =?us-ascii?Q?wZbuVfcLcmj4jPb4q9JVVuwwCYZvANxIFMC0RpE3gBgY1H9ptwhMAmNC4mQP?=
 =?us-ascii?Q?LPc2rL/ZKiKxnU+4035xmiquqa3uB041fPgQtrgYbmNwTY23eeHtj2hipO4u?=
 =?us-ascii?Q?MQUxUPcUVBe5/gSMd1rklmQvzpHFi3csKeeBApevUOs8hbluImVHGBsHWGNs?=
 =?us-ascii?Q?gbD2qQVOzPplkMEJfKs7UpseZsjOPXImVTT98r1ThK1UfhT8ay+B6cvU8IL4?=
 =?us-ascii?Q?vf5t/Mz+SkvOnr7nDxtSeRCB60yBiEM2rK7Uq4qlvlPs3YaXVFcckChF+bSz?=
 =?us-ascii?Q?sUqa2UYbuTpndQF7bWhcK6ydt+zApbOFJRFdDqz10mrpNXD3BcWw+J8tObBv?=
 =?us-ascii?Q?sn6kiVPzuk9S4bVypVc+KZNuYuF3xMLOlOeHuqEEry6CilezqmWQNdJOwXUC?=
 =?us-ascii?Q?04BlEYRxkQUCRhFJEGGThwXn7/6k0HKnkhgaHjy/AZTx+a9ukFmd2r0gaMEj?=
 =?us-ascii?Q?VCVg7hs8ITWHRnKQ5gc8ilfBL8moMrDwXslb+wyF0U5aOR3Y8jSfWuRI2yow?=
 =?us-ascii?Q?YB1mJEdXciIsTSYwXR22HRvWPQwwxwWq34eoxSUczuHbINeMlmRsmx9B82/D?=
 =?us-ascii?Q?1WGGaVRfqpk6ySzt0wE6szrbnGjH5OOUEp55WhEW+yWiQ4CNA0vyJd6ssjd1?=
 =?us-ascii?Q?6/XAY7btMlTQCtM/vrWUTgsqD9XGqKSDbwo9dxCFhQlJfRxtt4C1m12CxWYQ?=
 =?us-ascii?Q?esR7a82lphgyq/ss6afTtHrBeLo2/EjSeqkm5V7zDJosnQCs3oI/ZHYqdX6/?=
 =?us-ascii?Q?QPDwuRFddJIvnKfbv7Xd542jqYEM4tPLAL7gbplHYRL5nALw01n1iSUY4nBo?=
 =?us-ascii?Q?/vLshmPR0iA9h91BR9LGUs/i30vFL0jNl0ZrefgWKlFeHX8Q89cFPoBfncot?=
 =?us-ascii?Q?hHgIV5mMx3P3gxktqFOoq7vRJ4nbgc8oThMbSEUso1bHu3uG5lM1uDOg6RZj?=
 =?us-ascii?Q?DmHtKU4feE51xACmyrFYlfEg151QI4/Ma/hgCDMjqkorQsERlyRJ+w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IOcZfm4E4MlX3jZWGLjrBja3xVVyMtDU/ckHKYWXmuKQbDmFSDYwvaVhxwe0?=
 =?us-ascii?Q?yw0vp0Wx5Wj5hy2yuFWhYi63drbg5xFFJkzI1AsrKvmpex8L0nIC/+dRI4yf?=
 =?us-ascii?Q?jm6XZgx3Vi1srSkZUcGKyOrZzrF967F1RwcVF5mdUBec5d68SIujUj/xZI4D?=
 =?us-ascii?Q?YkDR6QSezndTOg5KsrA9fo6p5BKwq75vhRqlqT+JzOgV8qgXUdyc8yUGq7+L?=
 =?us-ascii?Q?PD97pbzTsv8Bk2vRRI1C83qDGzjI8agy1l55q9U7QpI9o0FtjHVWqIonvtud?=
 =?us-ascii?Q?xR/fCXhecZsbRWk8p+8SAHnmFAAXiGfVB3n4FkikhPoPv+/pTFS10JSIAnD6?=
 =?us-ascii?Q?t27x8fOBTFp+JYu/YzPEdTvfjPylcQvYXyk1t/oF2VeS0FovneMZkacWDM07?=
 =?us-ascii?Q?LxLfflWNyZJvG7oJCkFaeW4fH+hu87ZtW8mX9juTO7xYP75RYmgbsXUdyRSI?=
 =?us-ascii?Q?IMiSoN2rqEXWIgO10PAfR5Tc11iZlGXRpo+xc6oIKHqbsIlXL5TfC6DoUUu/?=
 =?us-ascii?Q?7VDsqg5TdEdgCFDo1WID6LtdJqeJtO6bEQox+8j+9WnNKs7V8RWhwyXnWDe1?=
 =?us-ascii?Q?4WZPIn3WVxy4jS/X+gKhyb79ocXHabIYa5ttKUETXkAsuxe62N+L5xSryPew?=
 =?us-ascii?Q?VhAbkSEXA+MEmENddoeMCdkbJdICLp+DzYeG/SLC3fpPweZRRq0p1qut9Vul?=
 =?us-ascii?Q?kreGFnjZTFBfz7eILW2KgNIMHDxqY3TQF4JT/+mVIRQ9eCnPL7lsBrouJXWN?=
 =?us-ascii?Q?qfAezVmaPEV3MGRzMzKLrGvLHT8yCfLDAGzJa/Z1mDEQ6nbdxI8KRxHIIyqe?=
 =?us-ascii?Q?XI5MbRAHOBDq0/qOtnpFHUUC51q6ui1dllRPVbaXBXWTpmrcyWlj5d//+N+v?=
 =?us-ascii?Q?9fHbmmLJhlmESzQoSf7+GwWZoPtDH6dBfBaJZiOI33LxCIKpLXOXIfuvKD3K?=
 =?us-ascii?Q?4RZfMeuFPg/qlQwAT5Vy4mqGqBCtHOqO26o2A6oaRQaMnPG2OJaZ2e9BYabr?=
 =?us-ascii?Q?K8TLooizxNHUCXU1TrMvZtrkKcH2J4foYJE2tlvCm8q8si0BOPnwob/K4v5B?=
 =?us-ascii?Q?kZ8+VPisaNJc+Ie8/tiJsZZfB2NJXjkiaTH1c0USskKTk6QEcWjP0UsOAhdV?=
 =?us-ascii?Q?FBNiCGaq4tcUSlKMBcH733UXn7f9/WfAN5y/rzMZw2104SS2ISc+Z77LPGfn?=
 =?us-ascii?Q?38gov2Fe1VHOybb1lMrDAGlJ1fmsW8kNlHPQ8f5QHHcB+txw238cAzDLB0OA?=
 =?us-ascii?Q?hXlB4ec0XIK5+a+THsQAe38EzcwxGADY+NRoFawalVgCP6W41MsnG2fvO6mW?=
 =?us-ascii?Q?2JJhr0OPlIYPDBKm9393zYZNlshdzuGo3mTP11IexkpV0SRCh1F/YJzRu3oR?=
 =?us-ascii?Q?CMRjLWNf8dxmAltU7EFbOX3CfcLEgLEuvwvAQZuqHZ1tgxYhyWWag2NbnpS0?=
 =?us-ascii?Q?HBspDvhjc885pD4c+JPo9mCjEoi9peTfz0qczlnzUzHW9011fRtq4Lm8DBtu?=
 =?us-ascii?Q?xbAZbjILl4oTXz1gooRunK+wCT7Rl9Tih2XX4savgBdwEAt0xnpiO1r633Gp?=
 =?us-ascii?Q?HW7t8cSCT9EmbZOLAZg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 463f2557-4210-41b3-d282-08ddf5e19c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 11:59:09.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h15n33EJpbLodQxbMrSZfovkrVme1+vFFF9SgTdHYYCZDUF1sjqwnQsmI1uFoMbqh5uh3a8nVBfxVE1j5XIwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks Bjorn for reviews.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, September 16, 2025 20:34
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Sep 16, 2025 at 04:13:18PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
>
> > +/* Synopsys */
> >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> >  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> >  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> >
> > +/* AMD MDB specific defines */
> > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
> > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
>
> > @@ -120,9 +213,22 @@ static void dw_edma_pcie_get_vsec_dma_data(struct
> pci_dev *pdev,
> >       u32 val, map;
> >       u16 vsec;
> >       u64 off;
> > +     u16 vendor =3D pdev->vendor;
> > +     int cap;
> >
> > -     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > -                                     DW_PCIE_VSEC_DMA_ID);
> > +     /*
> > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > +      * of map, channel counts, etc.
> > +      */
> > +     if (vendor !=3D PCI_VENDOR_ID_SYNOPSYS ||
> > +         vendor !=3D PCI_VENDOR_ID_XILINX)
> > +             return;
> > +
> > +     cap =3D DW_PCIE_VSEC_DMA_ID;
> > +     if (vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             cap =3D DW_PCIE_XILINX_MDB_VSEC_ID;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, vendor, cap);
>
> This looks correct, so it's OK as-is.  But it does require more analysis =
to verify than it
> would if you did it like this:
>
>   vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
>                                   DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
>   if (!vsec) {
>     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_VSEC_DMA_ID);
>     if (!vsec)
>       return;
>   }
>
> This way it's obvious from the pci_find_vsec_capability() calls themselve=
s (and could
> potentially be checked by coccinelle, etc) that we're using the Vendor ID=
 and VSEC
> ID correctly.
>

Instead of the above format, a clear assignment to vendor and cap would be =
good enough.
Reason for this is, if a third vendor comes and supports the same VSEC=3D0x=
6 id with similar
capabilities then it looks bulky to put another clause as given above. Inst=
ead of this a cleaner
approach would be to have a single pci_find_vsec_capability() and clear ass=
ignment to vendor
and cap variables to make it look cleaner. Eg:
switch (pdev->vendor) {
case PCI_VENDOR_ID_XILINX:
        vendor =3D pdev->vendor;
        cap =3D DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
case PCI_VENDOR_ID_SYNOPSYS:
        ...
default:
        return;
}
vsec =3D pci_find_vsec_capability(pdev, vendor, cap);

Please let me know your thoughts on this.

> > +     /* AMD specific VSEC capability */
>
> This should say "Xilinx specific VSEC capability" because the Vendor ID i=
n the
> device is PCI_VENDOR_ID_XILINX.  We shouldn't have to look up the corpora=
te
> ownership history and figure out that AMD acquired Xilinx.  That's not re=
levant in this
> context.
>

Sure, thanks for this clarification.

> > +     vsec =3D pci_find_vsec_capability(pdev, vendor,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
>
> But this one is wrong.  We do know that the device Vendor ID is either
> PCI_VENDOR_ID_SYNOPSYS or PCI_VENDOR_ID_XILINX from above, but we
> *don't* know what VSEC ID 0x20 means for Synopsys devices.
>
> We only know what VSEC ID 0x20 means for Xilinx devices.  So this has to =
be:
>
>   vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                   DW_PCIE_XILINX_MDB_VSEC_ID);
>

Sure, this will be addressed.

> Bjorn

