Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82442FD139
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 14:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbhATNSR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 08:18:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:15944 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbhATNHW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Jan 2021 08:07:22 -0500
IronPort-SDR: UXMAjBLa4vmyyEt+9WSM9lliaRqWYuqQirbLRlr41IffOyghOWpu4f5n0TQyWWyhfY+jSqHPz9
 t+TmwXBA0AMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="166192652"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="166192652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 05:05:36 -0800
IronPort-SDR: X8I9WmDp+y/Sjo6PPn9RKTX2sQwPOfsuf3+xOnbht23OAlyIo8r5qa6OF5DMYluvq2pLomajI4
 ZoX3Iefa4n3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="467072866"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2021 05:05:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 05:05:36 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 05:05:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Jan 2021 05:05:35 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 05:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGS9/wGx8mbx5QLehTft887/U5y260vqfvuJNwkHMBDijIHC63Jdn0m4zuHVVLfcFJzHjD2LqKjEURLxP66ZjM6rP5XOMbheIM3xTgc5QH7LCpO3uCLey1Adp9yN0RJ5OjqOSEND/C7NBwdxHlTNRcwAjlHdIKFKuHuS/hSw7vb6JorSLcRV1Xbc1e2se2Y7juj/lQujhKjHMsUk3XemeZEAItMx42RX2JNXK8juGQSWGqugdj0k4YleI9O1acrvd5BAsu0XxiFsKgNeDxrambFwqMqsK4fPtF4787CI00tuShLV+FLhlYjKoxEkpA4jA4+8ql9B12n41ZUQr9cO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpPc0I8KHXZJANGi5+atLopDMv4jELKYLZfJFRGp914=;
 b=CId/6RkUtbe7DZtZnsxxXrCbNVzDpbfzgd5Jv59acvL/jxhT+MZEcLhnZoL11zxLybNDVFG1BMTOgqrV/VnMTvXOOwYL4GYmqnV1d3bJn4DbnZNTrbLJKto8IRJRS1taG/ug8vLG1FN1lv0koUvwNtctg16M6wohosSWqZYFztBZZxss4JkZrMGWobHNG5i6LoUG224axArUcj+3Xdf1GSWyrMW7ofeE4o9V1DRuABFXED6LQwAjDATUVRHwzOsfBosWRfFEZoAx1iEg8JknnXVKMUfEvpkEvPDVttX4UNrg4tfHLpjAPWATmXVnumi4dcPDUUYj+P7TpH5l+cHOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpPc0I8KHXZJANGi5+atLopDMv4jELKYLZfJFRGp914=;
 b=CQsuPEuRvvqT1ndYKf686EMrv6CUbaA3FIdGS+n8n7ROF77o2GTKLI12qc1jKIB2QzUDA2wVAwXsq7PGmMMw6t0Nhk0dl95uf6RKytJp7xlsjUCuYLfVuzp9VgbHI0DqjGVxx7LkGhFJU8uDXzbx94CVL8dE3UtDsIWgwTUp8f0=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB0013.namprd11.prod.outlook.com (2603:10b6:301:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 20 Jan
 2021 13:05:34 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::b490:1116:e0fa:f42e]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::b490:1116:e0fa:f42e%4]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 13:05:34 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: Re: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel
 KeemBay AxiDMA
Thread-Index: AdbvLGJS1g85JOmrTmG2YlnZ8KFpfA==
Date:   Wed, 20 Jan 2021 13:05:34 +0000
Message-ID: <CO1PR11MB5026F694E4A231BAFA3F5184DAA29@CO1PR11MB5026.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [203.106.188.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8dbb4f-eca1-41c6-4011-08d8bd4412c7
x-ms-traffictypediagnostic: MWHPR11MB0013:
x-microsoft-antispam-prvs: <MWHPR11MB00131FD0CB8B9B3567F843D0DAA20@MWHPR11MB0013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajIw8Qezz8vwNZVXXdnNPqiKcd+YOEJYJGBeQU9pVAr//rfOtzEP9gRBhu+LELiKVtAFBf19I439BBeag/s+daGBSiQRLCHX/UC+7A9x+wBebbyTfKg+TLbT7plVjuX3ptoBkEjSmFQKlhQrlPSIZcn5X4CvLFABt5k3oynCNbsNYYDBOiOqnC9nFFQQeoBzXo4TTfzQj83o+/KXOO9TmSlODYfGFL+JuQqju7tgogWKRSVxo2iGYJJIlwjQTCiACKZiSAP0cx9mf7v5u1T62fQzusmoEbOS33XuqOabXwojNOj5smNClKjgaee8Lzg818jKazlbh5hLSsnAPWcfkZBGIX+buFaGGtc16fXzLLxSOwSLfWxO74aVs1ddgcKWmD9IL9FuYqdyZ9RloKCy3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(186003)(71200400001)(76116006)(26005)(55016002)(33656002)(110136005)(8936002)(54906003)(66446008)(9686003)(66574015)(478600001)(2906002)(316002)(45080400002)(7696005)(8676002)(86362001)(6506007)(66476007)(66556008)(4326008)(83380400001)(64756008)(5660300002)(52536014)(53546011)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EjiFFzY6mqYYwcrs4HpXGsJ/IbaYn/DUrADKNAr4nbTWZv6U7u0PkbMnzTnS?=
 =?us-ascii?Q?E0aq6KujlX739N4ZlEqtM9oHj4GC0kNybLf4ZmauMP4/JPnj6DScDK4JCON8?=
 =?us-ascii?Q?YcznUcR1YecJCezf56mqJ5PuJpdWRGLdG68kszCXHq5gcBQFsT5zowEETQVG?=
 =?us-ascii?Q?Q/FCnBw7Hw5fRmFvqZwybznbuL6Vo7PiVKm4V0rkc7MXQIQqkUB+VMVvJ6IK?=
 =?us-ascii?Q?jYvm+pL9PBxHOajhHQemywMJFTi13590jSSXHPghko8F7hFi7YJv0hnyafp/?=
 =?us-ascii?Q?X/dFIleZSGT7R3FtdNC1vG5xdgzlGTnC/BHBKdNrjTXa3el/eqSkO/j6narA?=
 =?us-ascii?Q?bW7TfzqTZoJjPVZxjts5YSrUhHrqSCv58P9gH/28K43gi4UOrj5kldL9/csx?=
 =?us-ascii?Q?ezfQ6bbUFU70kHm8h4O96SbdnEvJ4sv7NMGS14n9PxkV7QLRN3uv650Jd110?=
 =?us-ascii?Q?PLjet5Q0oUWxvS+RAhkh5hYrv8aG6tU73bOnS70O/JuEiPv+p8ExgUKufafx?=
 =?us-ascii?Q?ceWWsFMCwLl3Hj+6SgXwLQ+axPYPAdz2gx7Dd1MhLjV1nLTIZBMxRJOG1A0F?=
 =?us-ascii?Q?KCgR9UaDWa614//eyg9gy5QiGhqWrzc0Y+sgbbpg0CMetT3znvElAj9HnJap?=
 =?us-ascii?Q?mJIPwBRc9GBUD5pkjo+9Tks6axjk6AoFYaHqj4I1noOSsCtYP8ZkqbMfeYW6?=
 =?us-ascii?Q?PfSciRkLaSceC3I2i8m8Bpfbq5W0BOdVxB5plJREIui/HaWO4iNgpULHIFKn?=
 =?us-ascii?Q?yYTMEPg70/ge6K9Wpm4Zc2c7TflC+pz6C3Ne/dtxaQs00eOL+dWZ/RTnxSkf?=
 =?us-ascii?Q?7hmWj/lq13ZGh8MRT3SBirgK0CD7ebuHYC2aFgseDtrEfAQ62yKOfcMHzBNB?=
 =?us-ascii?Q?YvywMjwiZ/EjQigXsIh8tgAqaIf3A1KXHOk0rXV0dMS6kxY51/LU7Up+g3CH?=
 =?us-ascii?Q?KmYR7FqyS2D5nObBlHSqQe585qTFUkNXfE/65skOXyfDrjsO6o7QNqMzmQjO?=
 =?us-ascii?Q?3dnHZfJNR8AsDAI/O0mK96j7TfbinupMl6GAhzqMHtTLR6pNxykAQhB8rxh9?=
 =?us-ascii?Q?JzmrhPLZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8dbb4f-eca1-41c6-4011-08d8bd4412c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 13:05:34.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUAFOn5XK+kldyVyrg2y+73/RTZ/sSSJeMcFW2XMof+bWuN19QeZtB60543F/Ld2nTK0o9C9qbnuDZLUamrKxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0013
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eugeniy Paltsev,

Could you please resend your below Reviewed-by and tested-by tag with plain=
 text format?
I am not seeing your below acknowledgement reflected to the mailing list.

In fact, when I replied on top of your mail, I am receiving below errors:

The following message to <linux-kernel@vger.kernel.org> was undeliverable.
The reason for the problem:
5.3.0 - Other mail system problem 550-'5.7.1 Content-Policy reject msg: The=
 message contains HTML subpart, therefore we consider it SPAM or Outlook Vi=
rus.  TEXT/PLAIN is accepted.! BF:<H 0.000529886>; S1731521AbhATMql'

The following message to <devicetree@vger.kernel.org> was undeliverable.
The reason for the problem:
5.3.0 - Other mail system problem 550-'5.7.1 Content-Policy reject msg: The=
 message contains HTML subpart, therefore we consider it SPAM or Outlook Vi=
rus.  TEXT/PLAIN is accepted.! BF:<H 0.000529886>; S1731521AbhATMql'

The following message to <dmaengine@vger.kernel.org> was undeliverable.
The reason for the problem:
5.3.0 - Other mail system problem 550-'5.7.1 Content-Policy reject msg: The=
 message contains HTML subpart, therefore we consider it SPAM or Outlook Vi=
rus.  TEXT/PLAIN is accepted.! BF:<H 0.000529886>; S1731521AbhATMql'

Thanks
Regards
Jee Heng

________________________________________
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=20
Sent: 18 January 2021 8:54 PM
To: Sia, Jee Heng <jee.heng.sia@intel.com>; vkoul@kernel.org
Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-ker=
nel@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org
Subject: Re: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay=
 AxiDMA

Hi Sia Jee Heng,

Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

I've runtime tested this series on HSDK SoC/board, so
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

---
 Eugeniy Paltsev

________________________________________
From: Sia Jee Heng <jee.heng.sia@intel.com>
Sent: Tuesday, January 5, 2021 03:42
To: vkoul@kernel.org <vkoul@kernel.org>; Eugeniy Paltsev <paltsev@synopsys.=
com>; robh+dt@kernel.org <robh+dt@kernel.org>
Cc: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>; =
dmaengine@vger.kernel.org <dmaengine@vger.kernel.org>; linux-kernel@vger.ke=
rnel.org <linux-kernel@vger.kernel.org>; devicetree@vger.kernel.org <device=
tree@vger.kernel.org>
Subject: [PATCH v9 00/16] dmaengine: dw-axi-dmac: support Intel KeemBay Axi=
DMA=20
=20
The below patch series are to support AxiDMA running on Intel KeemBay SoC.
The base driver is dw-axi-dmac. This driver only support DMA memory copy
transfers. Code refactoring is needed so that additional features can be
supported.
The features added in this patch series are:
- Replacing Linked List with virtual descriptor management.
- Remove unrelated hw desc stuff from dma memory pool.
- Manage dma memory pool alloc/destroy based on channel activity.
- Support dmaengine device_sync() callback.
- Support dmaengine device_config().
- Support dmaengine device_prep_slave_sg().
- Support dmaengine device_prep_dma_cyclic().
- Support of_dma_controller_register().
- Support burst residue granularity.
- Support Intel KeemBay AxiDMA registers.
- Support Intel KeemBay AxiDMA device handshake.
- Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
- Add constraint to Max segment size.
- Virtually split the linked-list.

This patch series are tested on Intel KeemBay platform.

v9:
- Logic checked on apb_regs inside the function.
- Improved code scalability so that missing of apb_regs wouldn't failed
  the common callback functions.

v8:
- Rebased to kernel v5.11-rc1.
- Added reviewed-by tag from Rob.

v7:
- Added 'allOf' and '$ref:dma-controller.yaml#' in DT binding.
- Removed the dma-channels common description in DT binding.
- Removed the default fields in DT binding.

v6:
- Removed 'allOf' cases in DT binding.
- Added '>' at the end of the email address.
- Removed additional '|' at the start of description.
- Fixed space indent.
- Added proper constraint in DT binding.
- Removed second example in DT binding.

v5:
- Added comment to the Apb registers used by Intel KeemBay Soc.
- Renamed "hs_num" to "handshake_num".
- Conditional check for the compatible property and return error
  instead of printing warning.
- Added patch 16th to virtually split the linked-list as per
  request from ALSA team.

v4:
- Fixed bot found errors running make_dt_binding_check.
- Added minItems: 1 to the YAML schemas DT binding.
- Updated "reg" field to the YAML schemas DT binding.

v3:
- Added additionalProperties: false to the YAML schemas DT binding.
- Reordered patch sequence for patch 10th, 11th and 12th so that
  DT binding come first, follow by adding Intel KeemBay SoC registers
  and update .compatible field.
- Checked txstate NULL condition.
- Created helper function dw_axi_dma_set_hw_desc() to handle common code.

v2:
- Rebased to v5.10-rc1 kernel.
- Added support for dmaengine device_config().
- Added support for dmaengine device_prep_slave_sg().
- Added support for dmaengine device_prep_dma_cyclic().
- Added support for of_dma_controller_register().
- Added support for burst residue granularity.
- Added support for Intel KeemBay AxiDMA registers.
- Added support for Intel KeemBay AxiDMA device handshake.
- Added support for Intel KeemBay AxiDMA BYTE and HALFWORD device operation=
.
- Added constraint to Max segment size.

v1:
- Initial version. Patch on top of dw-axi-dma driver. This version improve
  the descriptor management by replacing Linked List Item (LLI) with
  virtual descriptor management, only allocate hardware LLI memories from
  DMA memory pool, manage DMA memory pool alloc/destroy based on channel
  activity and to support device_sync callback.

Sia Jee Heng (16):
  dt-bindings: dma: Add YAML schemas for dw-axi-dmac
  dmaengine: dw-axi-dmac: simplify descriptor management
  dmaengine: dw-axi-dmac: move dma_pool_create() to
    alloc_chan_resources()
  dmaengine: dw-axi-dmac: Add device_synchronize() callback
  dmaengine: dw-axi-dmac: Add device_config operation
  dmaengine: dw-axi-dmac: Support device_prep_slave_sg
  dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
  dmaengine: dw-axi-dmac: Support of_dma_controller_register()
  dmaengine: dw-axi-dmac: Support burst residue granularity
  dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
  dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
  dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD
    registers
  dmaengine: dw-axi-dmac: Set constraint to the Max segment size
  dmaengine: dw-axi-dmac: Virtually split the linked-list

 .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 126 ++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 697 +++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  34 +-
 4 files changed, 764 insertions(+), 132 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
txt
 create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.=
yaml


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
--=20
2.18.0
