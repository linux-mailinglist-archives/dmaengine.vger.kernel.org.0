Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9D2AE5F1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 02:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKKBig (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 20:38:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:44126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbgKKBig (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 20:38:36 -0500
IronPort-SDR: rhkNJ16n39RfQQ3rVSwMRqIWWmyu0+vVxDm8gLJkIKon4vnqY/WW4CD5OddtKJ5OhtZI6SGSg9
 Iyy4FW4VW8xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="169295576"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="169295576"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:38:34 -0800
IronPort-SDR: xbS+36t5bYkJ7JvknkIxNYX9q3vs2QSllbBiEdPv5/RRvXG9EJYADc2WkD7NnTZawAFYiDj5aQ
 6oJeC00s2jqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308644001"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2020 17:38:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:38:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:38:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpTQj1XoNAohUzSX0ybGObohWk/QS7uWys/8hPgA8ZGKXjthwIUIE0xG48B2juZVooOlcSfZffqnslPVVttwZUH8jqaoSsVDdjascilZmmwKdSOxEKJTRyKvrVsj42BFc2FXf1CbSytNGjGLjdeHFcjTtiwfT09QpEKrUHUvb7e5D+Nl3i26dtpUmmjByDU7x6g90L0CcPgmr+JsWP1vsEi71gfKKVlsJqcc4gukRIG8+VGdfzMqafmvoISCWPRPFjzCrdVrMmhQ7pSfD4nlyYOy5COcakpGWzc735gtdc2iBi+z/o/aFNOz3W1SN/Uj8K0fsSz6jaxwluMvzZuuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hLHpV34Llxvv4gUDZWeZX5s13m71eNfsAIcjaakwbQ=;
 b=XI3HVhcrkhGcAFqaWDx9WfYNen+x3zAp0DLRWCEXb2cJT07Ie4yT/Tpb5uKm5ZBB/HwZeoCkKE06yIHOUIfv32e8W+xgdry+SiedGA0JR0UZOWnTeStVwqbib82AHd7ndn0tBTxRt9/uJ7Kf5cvt79/IuVCKJIBze0c7DIWbz0XhsLwf1gYGaIajsKaMamfZ7f3tJPueIc0zm86Jr/UrveOJvjotjjvdVhOFo5p+tcAwrdIXcIER8YTEYC2vReue4dWC/aYg53Y99Pnifu0CVEAP0t1t/it12/sddTY7CyuLs5hX9qMBan+ZCN3+FV87IWRDK7/UPRPT7F01nelFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hLHpV34Llxvv4gUDZWeZX5s13m71eNfsAIcjaakwbQ=;
 b=Jlv4Ylf+JkvMCqRy5Po/0vx4BXjgz1t+JL7Z4YxJQXEgzhiTCcdCsW1avbU/bIWPyfNSc7dxxi4qdylfGOzVi9gxwRtpVlE0ClkHzPZaguthbwpwFDaQPSmTpL71teK2jPmi2nnCCOiRWCevBSppev7sbJomqr22Y3bfI88QGuk=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR11MB1806.namprd11.prod.outlook.com (2603:10b6:300:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 01:38:33 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60%3]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 01:38:33 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 07/15] dmaegine: dw-axi-dmac: Support
 device_prep_dma_cyclic()
Thread-Topic: [PATCH v2 07/15] dmaegine: dw-axi-dmac: Support
 device_prep_dma_cyclic()
Thread-Index: AQHWtnynUP/bz1/OVU2QzISZuNMgjKnCKU2A
Date:   Wed, 11 Nov 2020 01:38:32 +0000
Message-ID: <CO1PR11MB5026FE7E33170CA8C639D204DAE80@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-8-jee.heng.sia@intel.com>
 <20201109094216.GC3171@vkoul-mobl>
In-Reply-To: <20201109094216.GC3171@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [175.142.41.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae4ae52-63c4-456a-217d-08d885e28018
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-antispam-prvs: <MWHPR11MB1806CBF27FC306269227E4D9DAE80@MWHPR11MB1806.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTXgEJgtPcLxx4geFr85/OaiXK6b3Dmoq7aK41P9vWbRyGm+4mMCO/KsEopXFSI2BRrY0I/wEPCfamKT/YftEISsdbh30kulYtAgRE3CkEHEMbo9O24JMOZ0Ykxx8M+v2WSqYGUPykRsHvwkBarjDiozmGXS8KIaMQ/fHJbLuzeONOCVX5g5lDcGCrol0uVqFUaYO62Wr/kcmU4iXwRZu2qmQuCkFqkOxxU9SWPjQKseSV2LMiApAYdtLbyfqrkixAbDDccdfFFU4O5Xf/PLe/pWnBrjdniTCgVatDiI1iyvA32PNGfaSzMJior2MjOKLte11nO6nM3BSiJTlNv0CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(186003)(55016002)(4326008)(9686003)(52536014)(316002)(64756008)(66476007)(66946007)(66446008)(71200400001)(66556008)(76116006)(54906003)(33656002)(26005)(8936002)(6916009)(8676002)(7696005)(5660300002)(478600001)(6506007)(53546011)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xWOczmcrlQHfkhogOY/l8yOUQ+JtDoPymQSoY8uasO5QW0s+6u4K79O04m/1I7MhPh7r7zzZCIlU0P0XOk1iLFdSflEXfpZVM/6U/LkvSCR7MwncG8dks5zBvTzGbLSXEezNe/gjy0iIjyr/+50RXuhM89ILjC4KzpCGZXw3HDYCKYE57xSk5AIGQ6n36BxAtsZodi+zJhvGtb7VTMa396VmshmpzE7dcxBL4kEH5aXs/3qCiDMsTE+156lef5hrAOSnFpqvBWCjyB4sMKnHvM9bDVxcyS5TDB9NWAjWYxc4BJQAHP4QsRbVq2WUe1U6c/uIKkXqh8Gdx/tBRisLqSdUtpFO56oMRkb4t2XgJqJA5Yzee+kxM0/estQlTcZlt6jmSoThsuhtF23lutrDj3XaM4TcDAWGqtnHUPqxG6idzL4V1iaZfl6JhM9X5UbPvTh+rU1suiGSM9uoIDuGA0UGakG64KfBxtutfXyoIwNsI90DM+pXyDmAOzyfcoUDnIJ/0EeCmVXvMfQj2bHZJn8xjWsNCK/gNkFLdZzdtsRcWalrVF4Ek9w8Gkt4TwJY01NoCkfYSQm3v13TUTyS/+ibcZrxg3O+z9hQNCjfv6jX0upOwzIeVopJ4jOEmSRqowzsMDpjNr4FO0OHhcQ8xQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae4ae52-63c4-456a-217d-08d885e28018
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:38:32.9958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/iklbGccIbOGgU8DI3/yXBkDeqyQGLdQ9oq0mKUPB1mWQlYW1+XluJDgp6Ke9QcTcFKVnebmJ4DncPTmfchjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 09 November 2020 5:42 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 07/15] dmaegine: dw-axi-dmac: Support
> device_prep_dma_cyclic()
>=20
> On 27-10-20, 14:38, Sia Jee Heng wrote:
> > Add support for device_prep_dma_cyclic() callback function to benefit
> > DMA cyclic client, for example ALSA.
> >
> > Existing AxiDMA driver only support data transfer between memory to
> memory.
> > Data transfer between device to memory and memory to device in cyclic
> > mode would failed if this interface is not supported by the AxiDMA driv=
er.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 182 +++++++++++++++++-
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   2 +
> >  2 files changed, 177 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 1124c97025f2..9e574753aaf0 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/err.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -575,6 +577,135 @@ dma_chan_prep_dma_memcpy(struct dma_chan
> *dchan, dma_addr_t dst_adr,
> >  	return NULL;
> >  }
> >
> > +static struct dma_async_tx_descriptor *
> > +dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t
> dma_addr,
> > +			    size_t buf_len, size_t period_len,
> > +			    enum dma_transfer_direction direction,
> > +			    unsigned long flags)
> > +{
> > +	struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> > +	u32 data_width =3D BIT(chan->chip->dw->hdata->m_data_width);
> > +	struct axi_dma_hw_desc *hw_desc =3D NULL;
> > +	struct axi_dma_desc *desc =3D NULL;
> > +	dma_addr_t src_addr =3D dma_addr;
> > +	u32 num_periods =3D buf_len / period_len;
> > +	unsigned int reg_width;
> > +	unsigned int mem_width;
> > +	dma_addr_t reg;
> > +	unsigned int i;
> > +	u32 ctllo, ctlhi;
> > +	size_t block_ts;
> > +	u64 llp =3D 0;
> > +	u8 lms =3D 0; /* Select AXI0 master for LLI fetching */
> > +
> > +	block_ts =3D chan->chip->dw->hdata->block_size[chan->id];
> > +
> > +	mem_width =3D __ffs(data_width | dma_addr | period_len);
> > +	if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
> > +		mem_width =3D DWAXIDMAC_TRANS_WIDTH_32;
> > +
> > +	desc =3D axi_desc_alloc(num_periods);
> > +	if (unlikely(!desc))
> > +		goto err_desc_get;
> > +
> > +	chan->direction =3D direction;
> > +	desc->chan =3D chan;
> > +	chan->cyclic =3D true;
> > +
> > +	switch (direction) {
> > +	case DMA_MEM_TO_DEV:
> > +		reg_width =3D __ffs(chan->config.dst_addr_width);
> > +		reg =3D chan->config.dst_addr;
> > +		ctllo =3D reg_width << CH_CTL_L_DST_WIDTH_POS |
> > +			DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_DST_INC_POS |
> > +			DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_SRC_INC_POS;
> > +		break;
> > +	case DMA_DEV_TO_MEM:
> > +		reg_width =3D __ffs(chan->config.src_addr_width);
> > +		reg =3D chan->config.src_addr;
> > +		ctllo =3D reg_width << CH_CTL_L_SRC_WIDTH_POS |
> > +			DWAXIDMAC_CH_CTL_L_INC <<
> CH_CTL_L_DST_INC_POS |
> > +			DWAXIDMAC_CH_CTL_L_NOINC <<
> CH_CTL_L_SRC_INC_POS;
> > +		break;
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	for (i =3D 0; i < num_periods; i++) {
> > +		hw_desc =3D &desc->hw_desc[i];
> > +
> > +		hw_desc->lli =3D axi_desc_get(chan, &hw_desc->llp);
> > +		if (unlikely(!hw_desc->lli))
> > +			goto err_desc_get;
> > +
> > +		if (direction =3D=3D DMA_MEM_TO_DEV)
> > +			block_ts =3D period_len >> mem_width;
> > +		else
> > +			block_ts =3D period_len >> reg_width;
> > +
> > +		ctlhi =3D CH_CTL_H_LLI_VALID;
> > +		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
> > +			u32 burst_len =3D chan->chip->dw->hdata-
> >axi_rw_burst_len;
> > +
> > +			ctlhi |=3D (CH_CTL_H_ARLEN_EN |
> > +				burst_len << CH_CTL_H_ARLEN_POS |
> > +				CH_CTL_H_AWLEN_EN |
> > +				burst_len << CH_CTL_H_AWLEN_POS);
> > +		}
> > +
> > +		hw_desc->lli->ctl_hi =3D cpu_to_le32(ctlhi);
> > +
> > +		if (direction =3D=3D DMA_MEM_TO_DEV)
> > +			ctllo |=3D mem_width << CH_CTL_L_SRC_WIDTH_POS;
> > +		else
> > +			ctllo |=3D mem_width << CH_CTL_L_DST_WIDTH_POS;
> > +
> > +		if (direction =3D=3D DMA_MEM_TO_DEV) {
> > +			write_desc_sar(hw_desc, src_addr);
> > +			write_desc_dar(hw_desc, reg);
> > +		} else {
> > +			write_desc_sar(hw_desc, reg);
> > +			write_desc_dar(hw_desc, src_addr);
> > +		}
> > +
> > +		hw_desc->lli->block_ts_lo =3D cpu_to_le32(block_ts - 1);
> > +
> > +		ctllo |=3D (DWAXIDMAC_BURST_TRANS_LEN_4 <<
> CH_CTL_L_DST_MSIZE_POS |
> > +			  DWAXIDMAC_BURST_TRANS_LEN_4 <<
> CH_CTL_L_SRC_MSIZE_POS);
> > +		hw_desc->lli->ctl_lo =3D cpu_to_le32(ctllo);
> > +
> > +		set_desc_src_master(hw_desc);
> > +
> > +		/*
> > +		 * Set end-of-link to the linked descriptor, so that cyclic
> > +		 * callback function can be triggered during interrupt.
> > +		 */
> > +		set_desc_last(hw_desc);
> > +
> > +		src_addr +=3D period_len;
> > +	}
>=20
> apart from this bit and use of periods instead of sg_list this seems very=
 similar to
> slave handler, so can you please move common bits to helpers and
> remove/reduce duplicate code
[>>] sure, will try to reduce the common code.=20
>=20
> --
> ~Vinod
