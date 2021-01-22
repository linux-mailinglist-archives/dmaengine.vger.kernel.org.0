Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960CD300104
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jan 2021 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbhAVK5s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jan 2021 05:57:48 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48962 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbhAVKwi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jan 2021 05:52:38 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A37B9408DA;
        Fri, 22 Jan 2021 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1611312696; bh=xnKIG4GKC4LZLmEFSjgkQBR4DBI7Lm4nXqLVG20i+AY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fX8smfuYAfxk32Onupd8sUk60QxqCjLfHa1q8cGMv/mSPXsMtTdtDVbCcRTrjCODi
         kTjszYVC9ZrZD4Qhr2SgyTSDThgJkKShJE6GJIm1av39fbEoUWollPk6s9/11QbdAT
         11EzcyuR0l4ccNarBHkW0y94VfIclSKO7lJISPJJbFJARQKyKSIkzEODOk5MXpBWjj
         djq4UGZC35QmI8vP5A8qIDevJ1EE9sDa0yTytgd6M7/1j4hOcbWDMLOm5AW61SKTjE
         68B2wK2PIO/aerKsKmYNjj3u5vSyfxNEKjWwNG2kfRKTNB1VXdwB9OfbxPs9Wh/BJc
         HnbkikkX+Ss5Q==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 197B4A007C;
        Fri, 22 Jan 2021 10:51:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D8F7280218;
        Fri, 22 Jan 2021 10:51:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gqywDI8m";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jju9qNz4vGlIMFPDArLFjc8BDrFqbVuP97tFQlH1T5pVSIp4Lg/Ehk3FbZdNQ1XANg9VmaeZ0Tq0WqwT/M9Z97JpfGkGK1sOHcPDhdwijEpppxrPHyH//TFv26iN1zHcw25wI4sCLBIm9D1zMyOSG5HHDIsFG/BgSP+Tp0rogAx7tFpx0LbgHh1mA2a8fO1UaLmtz3wGxt0d/ydpmN5Fg5uxnbOtmOTI/IjPEWPMKNPIx7h/8yZ0F1kUSeUoz0Ib4Qm3FWHenhZWxDHJyGU/BS7VWl5B0GfvOgGHhUl3BjYAcVBC0BmFUplPSkhXGmKOQrAqNNG85NQ05yFhex9iNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnKIG4GKC4LZLmEFSjgkQBR4DBI7Lm4nXqLVG20i+AY=;
 b=nJac0jipwqMzr5TAgX9do3dI78pI/txQRni2g2CKiH+SXBqUBGf3PNkyyGnV3I4xvlNje6yDgEQ3kpKH0O7fnwHBtSqerYtSIeyBp+FxnW6i4WftBJ1o0kk6HBEp6CRAttlU3ImSzloDYsZ/yxERBAaakYtMbpe+4IpLU5028MR1UFNITnkHpk9bSVBx60SnTxvXfn53adsGrqcZNdMzH2Pzc3r5JOZv6BUaE3Cssd/rCpUDc/rZRhVwefzzDPFGYrLsS91wxnyjU0ulAuK+NR1qjMh3UxQ8CSDeRm9YHck7hSAVg1V0aBrJfJe7rkOXXyU4xJP758c8H1jQh32ZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnKIG4GKC4LZLmEFSjgkQBR4DBI7Lm4nXqLVG20i+AY=;
 b=gqywDI8mjf6xaB/6PSY7UIo2ENXZT1bjKVYXm464ZAzvPFQ6yHUYpGSPV8RceIdzVXMEAyzq+J7DG1+Rdhboke5RuTk2Rs1gv4zuJklwW31YDVB8Ye4OgPUEemKsGnXKIBgph666GtLBVv/INeeJA6GrHO1CPwj4KuXBT4aZqFo=
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 (2603:10b6:301:4d::15) by MWHPR12MB1440.namprd12.prod.outlook.com
 (2603:10b6:300:13::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 10:51:33 +0000
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::b1a3:e6e8:721a:bbbb]) by MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::b1a3:e6e8:721a:bbbb%9]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 10:51:33 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHW4v4iYc1B5Wm1T0SeNEm9pWgBF6ozkojp
Date:   Fri, 22 Jan 2021 10:51:33 +0000
Message-ID: <MWHPR1201MB002999C6B459650FE0FBF990DEA00@MWHPR1201MB0029.namprd12.prod.outlook.com>
References: <20210105004306.13588-1-jee.heng.sia@intel.com>
In-Reply-To: <20210105004306.13588-1-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db2917a2-5cf2-4f0b-052d-08d8bec3aee4
x-ms-traffictypediagnostic: MWHPR12MB1440:
x-microsoft-antispam-prvs: <MWHPR12MB144079E2543AA32B30515C5BDEA09@MWHPR12MB1440.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUlsU0Zdd7y651KuOO7coHazrpXiDIHiwiSaBUoTuLnR295q6afRIFu1sI0D02iiZK5ZJrPjegF6vp4eTwQwo2AH8diIE7pHiSdRqiRVjw7OLqqHTeia1+f9bY0uLFMdUouyMtQD2Zb0cl0yOQJV9zm5yxbY3zHoj2jeIbSW3E4IvtYFcy1pXwHjTOSKwjuGoD9SZSthCB5PLSrFoAn0UQQkJFmNxjLSiwBNYmO0+PQsZJwwzAY+YZg1yhcDnWC61nonFQb0fkv28O8y5b9XiMv8MTxjYew/uP2xLcj7KjoD1HzeceGcWimjmrximTn/V5aGq0MPAL14e0pPjCiVkrTcB5SknByKFpaIvYmij3bwM8oxWFAxktkT9AWlGO4GGQabtSpacCxPGy0c0vFYSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0029.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(396003)(346002)(71200400001)(186003)(5660300002)(4326008)(8936002)(8676002)(53546011)(33656002)(6506007)(26005)(54906003)(2906002)(55016002)(86362001)(52536014)(83380400001)(110136005)(478600001)(66556008)(66476007)(91956017)(64756008)(76116006)(9686003)(316002)(66946007)(7696005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?VTdUz2Yjs6MraaTSQ3RlfBaTaH2FJdyL/dMhaxncBKb6ZCY6N7tpafgVa+?=
 =?iso-8859-1?Q?cemnYpPflWuaxpOVG+AIJ/y43l0se1FCmDezVugw94DP+2W3GaJGNzrSCF?=
 =?iso-8859-1?Q?MkkdIyhn54lJdvmxwRcKtsoB55RFjjitR3TIvWw33mVnU+4jdz2p8gfLny?=
 =?iso-8859-1?Q?4D79ozrkXFOEOVWAHNQqHUgf+EabZWg/um8ZkaNQMIlpetf9K/fNek+1ei?=
 =?iso-8859-1?Q?HVA1EBRBtUYTQPIXEqHpxSMjPEEbGdwhrkBtmTuQmh0V/R274PHMUMyb92?=
 =?iso-8859-1?Q?CocOGrlJ71JTCen6TsZWPGpMjGYJxPkZ3kF3cV3FH8w/M8NIIg4H3Ay0si?=
 =?iso-8859-1?Q?PmAFWcD5VBBm5obbFjnJLTTLaEe3uVp9qGjJNA7Lk9Scfs97IAwOxVNBRh?=
 =?iso-8859-1?Q?UxBqMZUkSXGgQ9NC/qvyKWJZiakwANFlEhHlbYoL12SetumcUlqkW4vjdZ?=
 =?iso-8859-1?Q?jLsexQ+WXbWly/1D9mKX1Fj8sntF59z6EgKHyfNGV9rR59knIoWbOmK/2z?=
 =?iso-8859-1?Q?KKtKno1QI//ilKAPPPufnqWMJm5R0aSTmbnSmJmfZtEY4rn5Y3IJSJuGFS?=
 =?iso-8859-1?Q?egwYyzrsXONHBcYcMP90E05FtVzweTfQ61RJgxoRf/MMAicg722KMmIO0z?=
 =?iso-8859-1?Q?yRzeEPVYStLqTI2tD9zGXeLbvhGlRQ6+bUqJv8uaO0zF60FbIhyWJaAVvN?=
 =?iso-8859-1?Q?GSYjYM1MCpnA01gWy53q0Uu+8nUgO4a9D4K0iBZha6mHqJMNbW4ckAdi6v?=
 =?iso-8859-1?Q?6Id7gj2SNHM9OKXTIuxIzbN21Cse7dkpc91W1cKikkIsNDRYHE2xyECntJ?=
 =?iso-8859-1?Q?lvPm5k0rf3WPaTihbugAnKea6/nhsfr36Ly8exz0kt/l4cAJkTctsNp1eJ?=
 =?iso-8859-1?Q?+CrOXQrXVbN/k4xQNa9tm4CaFz4fm/dS93pAfgMoa84LFLqX3NvxvJ3eL6?=
 =?iso-8859-1?Q?dIzzwyKK0XKFmNnXPI0X/22PWffQW2ZbecKq/MBmXwA824HwOLpXMpUFKP?=
 =?iso-8859-1?Q?nxzXGEA+vauJUZA3A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0029.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2917a2-5cf2-4f0b-052d-08d8bec3aee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 10:51:33.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pw+2FahLym28Efv4fjr7KPcnRbXkODBXQpNxTl9snX47DmCOHvfqWrIG5c0u6B67niJ2GenIlrC5Zo4U8EpS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia Jee Heng,=0A=
=0A=
resending tags as they weren't delivered to 'dmaengine@vger.kernel.org' lis=
t:=0A=
 =0A=
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
I've runtime tested this series on HSDK SoC/board, so=0A=
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
---=0A=
=A0Eugeniy Paltsev=0A=
=0A=
=0A=
From: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
Sent: Tuesday, January 5, 2021 03:42=0A=
To: vkoul@kernel.org <vkoul@kernel.org>; Eugeniy Paltsev <paltsev@synopsys.=
com>; robh+dt@kernel.org <robh+dt@kernel.org>=0A=
Cc: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>; =
dmaengine@vger.kernel.org <dmaengine@vger.kernel.org>; linux-kernel@vger.ke=
rnel.org <linux-kernel@vger.kernel.org>; devicetree@vger.kernel.org <device=
tree@vger.kernel.org>=0A=
Subject: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay Axi=
DMA =0A=
=A0=0A=
The below patch series are to support AxiDMA running on Intel KeemBay SoC.=
=0A=
The base driver is dw-axi-dmac. This driver only support DMA memory copy=0A=
transfers. Code refactoring is needed so that additional features can be=0A=
supported.=0A=
The features added in this patch series are:=0A=
- Replacing Linked List with virtual descriptor management.=0A=
- Remove unrelated hw desc stuff from dma memory pool.=0A=
- Manage dma memory pool alloc/destroy based on channel activity.=0A=
- Support dmaengine device_sync() callback.=0A=
- Support dmaengine device_config().=0A=
- Support dmaengine device_prep_slave_sg().=0A=
- Support dmaengine device_prep_dma_cyclic().=0A=
- Support of_dma_controller_register().=0A=
- Support burst residue granularity.=0A=
- Support Intel KeemBay AxiDMA registers.=0A=
- Support Intel KeemBay AxiDMA device handshake.=0A=
- Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.=0A=
- Add constraint to Max segment size.=0A=
- Virtually split the linked-list.=0A=
=0A=
This patch series are tested on Intel KeemBay platform.=0A=
=0A=
v9:=0A=
- Logic checked on apb_regs inside the function.=0A=
- Improved code scalability so that missing of apb_regs wouldn't failed=0A=
=A0 the common callback functions.=0A=
=0A=
v8:=0A=
- Rebased to kernel v5.11-rc1.=0A=
- Added reviewed-by tag from Rob.=0A=
=0A=
v7:=0A=
- Added 'allOf' and '$ref:dma-controller.yaml#' in DT binding.=0A=
- Removed the dma-channels common description in DT binding.=0A=
- Removed the default fields in DT binding.=0A=
=0A=
v6:=0A=
- Removed 'allOf' cases in DT binding.=0A=
- Added '>' at the end of the email address.=0A=
- Removed additional '|' at the start of description.=0A=
- Fixed space indent.=0A=
- Added proper constraint in DT binding.=0A=
- Removed second example in DT binding.=0A=
=0A=
v5:=0A=
- Added comment to the Apb registers used by Intel KeemBay Soc.=0A=
- Renamed "hs_num" to "handshake_num".=0A=
- Conditional check for the compatible property and return error=0A=
=A0 instead of printing warning.=0A=
- Added patch 16th to virtually split the linked-list as per=0A=
=A0 request from ALSA team.=0A=
=0A=
v4:=0A=
- Fixed bot found errors running make_dt_binding_check.=0A=
- Added minItems: 1 to the YAML schemas DT binding.=0A=
- Updated "reg" field to the YAML schemas DT binding.=0A=
=0A=
v3:=0A=
- Added additionalProperties: false to the YAML schemas DT binding.=0A=
- Reordered patch sequence for patch 10th, 11th and 12th so that=0A=
=A0 DT binding come first, follow by adding Intel KeemBay SoC registers=0A=
=A0 and update .compatible field.=0A=
- Checked txstate NULL condition.=0A=
- Created helper function dw_axi_dma_set_hw_desc() to handle common code.=
=0A=
=0A=
v2:=0A=
- Rebased to v5.10-rc1 kernel.=0A=
- Added support for dmaengine device_config().=0A=
- Added support for dmaengine device_prep_slave_sg().=0A=
- Added support for dmaengine device_prep_dma_cyclic().=0A=
- Added support for of_dma_controller_register().=0A=
- Added support for burst residue granularity.=0A=
- Added support for Intel KeemBay AxiDMA registers.=0A=
- Added support for Intel KeemBay AxiDMA device handshake.=0A=
- Added support for Intel KeemBay AxiDMA BYTE and HALFWORD device operation=
.=0A=
- Added constraint to Max segment size.=0A=
=0A=
v1:=0A=
- Initial version. Patch on top of dw-axi-dma driver. This version improve=
=0A=
=A0 the descriptor management by replacing Linked List Item (LLI) with=0A=
=A0 virtual descriptor management, only allocate hardware LLI memories from=
=0A=
=A0 DMA memory pool, manage DMA memory pool alloc/destroy based on channel=
=0A=
=A0 activity and to support device_sync callback.=0A=
=0A=
Sia Jee Heng (16):=0A=
=A0 dt-bindings: dma: Add YAML schemas for dw-axi-dmac=0A=
=A0 dmaengine: dw-axi-dmac: simplify descriptor management=0A=
=A0 dmaengine: dw-axi-dmac: move dma_pool_create() to=0A=
=A0=A0=A0 alloc_chan_resources()=0A=
=A0 dmaengine: dw-axi-dmac: Add device_synchronize() callback=0A=
=A0 dmaengine: dw-axi-dmac: Add device_config operation=0A=
=A0 dmaengine: dw-axi-dmac: Support device_prep_slave_sg=0A=
=A0 dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()=0A=
=A0 dmaengine: dw-axi-dmac: Support of_dma_controller_register()=0A=
=A0 dmaengine: dw-axi-dmac: Support burst residue granularity=0A=
=A0 dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA=0A=
=A0 dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields=0A=
=A0 dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support=0A=
=A0 dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake=0A=
=A0 dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD=0A=
=A0=A0=A0 registers=0A=
=A0 dmaengine: dw-axi-dmac: Set constraint to the Max segment size=0A=
=A0 dmaengine: dw-axi-dmac: Virtually split the linked-list=0A=
=0A=
=A0.../bindings/dma/snps,dw-axi-dmac.txt=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 39 -=
=0A=
=A0.../bindings/dma/snps,dw-axi-dmac.yaml=A0=A0=A0=A0=A0=A0=A0 | 126 ++++=
=0A=
=A0.../dma/dw-axi-dmac/dw-axi-dmac-platform.c=A0=A0=A0 | 697 ++++++++++++++=
+---=0A=
=A0drivers/dma/dw-axi-dmac/dw-axi-dmac.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 34 +-=
=0A=
=A04 files changed, 764 insertions(+), 132 deletions(-)=0A=
=A0delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dma=
c.txt=0A=
=A0create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dma=
c.yaml=0A=
=0A=
=0A=
base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62=0A=
-- =0A=
2.18.0=0A=
