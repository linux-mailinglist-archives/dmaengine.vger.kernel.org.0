Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28EB26EEFB
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 04:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgIRCcQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 22:32:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:8752 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbgIRCcP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 22:32:15 -0400
IronPort-SDR: g0iG2c3PATPaQimNWTwaaEXMcvtBsrxqbV6Wfdc/iCtKz+zyK3feV3iL6y6mIf1+clMRfGgXgU
 sSKGpnb/Mm+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244673878"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="244673878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:32:09 -0700
IronPort-SDR: MYdfUVKiiabalm86muy85UA5YlPO3kYf7mWqaOrx/6fFTPS8DedTgWUouGna8rireZMJUCOB4P
 1BW5pMDqU5WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="289195379"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2020 19:32:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 19:32:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 19:32:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Sep 2020 19:32:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Sep 2020 19:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpyGMaqPN2RUfneDai6zd0HSfZU8rNy53/Skrhouti611Ru4NQVUEbrzw0xufNTcmXsV+DOrBq8qBfFhRQ4IdwDQ7hUXH+Rfcss/4l/n3QALI9AesnksrCjbq/cXZRSLLI2Pq/hFBtJWs+I89DxuVylKDXxzPQo8IluD0DiKa67YX+bsicIqReotrnLH6Y3JYD19Mwh9vJlQ5jVzPVe/Lv0J39V7dwdUQwzH0EAbhn6/GgR4tJEtLNYFtzX1W4W7DQFjH+NysuLhyr0uJUK8bfqf7Ql44/oVToi5bY+fqPXldZBRFskdwc14bsaw1aCGlPJeoBnGToIBHUMu+ZhOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jdzK9dBYf3YCXVAESrcQLIeX7QiULV53gsubwSTLP0=;
 b=VKX/sOgPRrSynVNOUrPMXdNRzvR82hB9ZrKIS8dQ7YuoF2CG1QRQmoE+BVOIom0F1gmKD0vYw0EWzpF/1sHBqWis/bHzV9Kt/HLFYjoFlsK4R2R69UGabKqNViLjPhf/8VRcs/hwtNOtdoJ+HPgjnM+kiAFvZwX990lc2SiTSQ8yq2fKUXxrBOj/GNnu1P0znT1DeDuh4tKlkbgTCXk3P/EaJly71mLrHD36zAgVUT5Ak/ZAxPWMNwYQZ0OBYXvdheNXIdAoM3yiCQ7NakgIKTFC6ruKpZZY+VCxeSn93AAboXDev7KjQjWasXutbiIhvh28SFFZR5I4HVoYz3rQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jdzK9dBYf3YCXVAESrcQLIeX7QiULV53gsubwSTLP0=;
 b=BYnrMB2KfQNDZq2QLeZd9/A9koxCPxu1dE9Oz+Wt5/eja2bnjJuPbMKk4QRwm0mb8MEO5U86rrBnnhlwotORQZh36fuB7YqmSYDJLyJFqxGF9BxM+53XjB89vAdqI/Heali9/OwP3JMvxCzLjYtLeIUnHjRQnJpIqN+mskczLFA=
Received: from BYAPR11MB3206.namprd11.prod.outlook.com (2603:10b6:a03:78::27)
 by BYAPR11MB3845.namprd11.prod.outlook.com (2603:10b6:a03:b4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 02:31:51 +0000
Received: from BYAPR11MB3206.namprd11.prod.outlook.com
 ([fe80::a9ad:315:e658:3dd0]) by BYAPR11MB3206.namprd11.prod.outlook.com
 ([fe80::a9ad:315:e658:3dd0%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 02:31:51 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and
 channel management
Thread-Topic: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and
 channel management
Thread-Index: AQHWgqMw5WhHOPqkbkGlBOQDRdxdMqltwJJg
Date:   Fri, 18 Sep 2020 02:31:50 +0000
Message-ID: <BYAPR11MB3206E7BF9AEC346822F22CF3DA3F0@BYAPR11MB3206.namprd11.prod.outlook.com>
References: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
In-Reply-To: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.52.83.167]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f4f015a-4d8e-47f6-54b7-08d85b7affe8
x-ms-traffictypediagnostic: BYAPR11MB3845:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB38450C7BEC937ECCC164DD84DA3F0@BYAPR11MB3845.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rF6z1lAKT/xvnzrp+hzXtur1L2c8Zn2zL6Y+JibMsG5uB/3p03eIsOTaPzUc+0bvJDTGvMu58nsWhZrR9IYou6HePlPFdHithdpMrJ3PbQQvObu2lubkNYFncyLSZRuXjbta9ZLJfbbfJ/v7FBKERy0u1qtmBFtbhi+YgowwDewJdcJJ7qMiAuEI0aAognZqwSwRcDtkZAg91m632tovslBv6fPFGTXzy3eJkH/CgyOMKuRhIu/GGmzRs5Gx2HVEtvue62SBDkCoNT7yZO5JE/DF70xse2hYrNfdUkzpOgCPSim5YHYTLKam9SXJqQw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(107886003)(4326008)(83380400001)(478600001)(26005)(316002)(8936002)(54906003)(66946007)(66446008)(86362001)(66476007)(66556008)(186003)(6916009)(7696005)(76116006)(64756008)(5660300002)(55016002)(52536014)(8676002)(2906002)(53546011)(6506007)(55236004)(9686003)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jAXYhNrDOKkegkIHBi1FPe0geFWryJwc45w4LmRwz+5E0ZZaTJWVz89T5FWQdZmE80vIswKO5fPiZzW/sAIxCLNfxSap+JyD30TfIehTxnA3CUKa7s3//HcO9sUxEkj9qfOUBIAhEKNepjBqJawINqJ3hgPn2tpoGmFdzP76IkfqN+5Ezts9ZlmYnaCD72WU+BvWqrwi52HtsbpnWWURR3c/RvwtpBAN6tIh3FGdsvTmnXDFv0tFIbxJQjR77sQji0PLYki0RcsmI2fLIQHINDTlnewEEI3tTWOXy5J3sfhXLSBL+svp3JFHwN6n0taBhjx9oqoW2UbLQrJwS0sQEfhSf8TjaUBcEwje2Czd5lHUL/mZgSdEHjxiGWLAa+VT3ANNdGigey0kfBkVEKhqjINAqBs+hTMFIWBKa3BqHf9TJaSBDfLEQ6wl4evHnl3aRBHhZEFfQXovBKXJaF35H0BzwkExoKI6oMVj+rgc8jeXznehQEY7a9ywBMYCrN9q4Pp6PyRUbbJ9bq/eBUO3AIUfDuDtvDcRAisEsP0VxpFoG3FiHk5dqrNZNzB1l/UXix3YPGuJQjfcr7WcqmA34r6FuhLEgByGpGrtrU5SF3H9yAVeN4qGqIv6dc15A2Hr/MwieJoEC0ANA0t9xI9NAg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4f015a-4d8e-47f6-54b7-08d85b7affe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:31:50.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgVbNDmtIIpcDn0uncN7hUrhh7cQERm2+lpfKRFIefqmu70T73+Nl7R5UB4AToq/xvpyNuJOLC13EDSZKh1cGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3845
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod, Hi Paltsev,

This patch series has been sent 2 weeks ago, but yet to receive a comment.=
=20
This patch series have been reviewed by Andy before sent out.

May I know if you have further comment on the patches?

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: Sia, Jee Heng <jee.heng.sia@intel.com>
> Sent: 04 September 2020 5:52 PM
> To: dmaengine@vger.kernel.org
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; Sia, Jee Heng <jee.heng.sia@intel.com>
> Subject: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and chan=
nel
> management
>=20
> The below patch series are to support AxiDMA running on Intel KeemBay SoC=
.
> The base driver is dw-axi-dmac but code refactoring is needed to improve =
the
> descriptor management by replacing Linked List Item (LLI) with virtual de=
scriptor
> management, only allocate hardware LLI memories from DMA memory pool,
> manage DMA memory pool alloc/destroy based on channel activity and to
> support device_sync callback.
>=20
> Note: Intel KeemBay AxiDMA related changes and other DMA features are to =
be
> submitted as we need to get the fundamental changes approved first prior =
to
> add additional DMA features on top.
>=20
> This patch series are tested on Intel KeemBay platform.
>=20
> Sia Jee Heng (4):
>   dt-bindings: dma: Add YAML schemas for dw-axi-dmac
>   dmaengine: dw-axi-dmac: simplify descriptor management
>   dmaengine: dw-axi-dmac: move dma_pool_create() to
>     alloc_chan_resources()
>   dmaengine: dw-axi-dmac: Add device_synchronize() callback
>=20
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |  39 -----
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 124 ++++++++++++++
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 190 ++++++++++++---=
---
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |  11 +-
>  4 files changed, 245 insertions(+), 119 deletions(-)  delete mode 100644
> Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
>=20
> --
> 1.9.1

