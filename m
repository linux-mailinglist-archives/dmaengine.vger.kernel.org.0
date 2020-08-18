Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAA2482F0
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHRK1r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 06:27:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40654 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRK1q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 06:27:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07IAReZO003390;
        Tue, 18 Aug 2020 05:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597746460;
        bh=8xkBadz85cSC+Zl1n9wGXqzdc8DH2yqT3Qiku2kAblw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=BlejnWNNhXfa2jmfFm5+Gu9xiQFI5A98q/H1lZVldl6GAy/Oi1m5IsPFRdbjW5Vpi
         MHGr7oy7vKwnat4RaZwpxih/DBIdRyrzMBsXwTCChBtDu+hvHFW2QoFXoHnw0ptwwu
         83Ya/fJ/l2wop6gc1uYBWeUygoD0tlbd2Qj/Ea18=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IAReWK096463;
        Tue, 18 Aug 2020 05:27:40 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 18
 Aug 2020 05:27:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 18 Aug 2020 05:27:40 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IARbcJ057381;
        Tue, 18 Aug 2020 05:27:38 -0500
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>,
        <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>,
        <chuanhua.lei@linux.intel.com>, <malliamireddy009@gmail.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
X-Pep-Version: 2.0
Message-ID: <70848117-ec29-d293-6603-cbf47dec35d4@ti.com>
Date:   Tue, 18 Aug 2020 13:29:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/08/2020 13.16, Peter Ujfalusi wrote:

=2E..

>> +static void dma_issue_pending(struct dma_chan *chan)
>> +{
>> +	struct ldma_chan *c =3D to_ldma_chan(chan);
>> +	struct ldma_dev *d =3D to_ldma_dev(c->vchan.chan.device);
>> +	unsigned long flags;
>> +
>> +	if (d->ver =3D=3D DMA_VER22) {
>> +		spin_lock_irqsave(&c->vchan.lock, flags);
>> +		if (vchan_issue_pending(&c->vchan)) {
>> +			struct virt_dma_desc *vdesc;
>> +
>> +			/* Get the next descriptor */
>> +			vdesc =3D vchan_next_desc(&c->vchan);
>> +			if (!vdesc) {
>> +				c->ds =3D NULL;
>> +				return;
>> +			}
>> +			list_del(&vdesc->node);
>> +			c->ds =3D to_lgm_dma_desc(vdesc);
>=20
> you have set c->ds in dma_prep_slave_sg and the only way I can see that=

> you will not leak memory is that the client must terminate_sync() after=

> each transfer so that the synchronize callback is invoked between each
> prep_sg/issue_pending/competion.
>=20
>> +			spin_unlock_irqrestore(&c->vchan.lock, flags);
>> +			ldma_chan_desc_hw_cfg(c, c->ds->desc_phys, c->ds->desc_cnt);
>> +			ldma_chan_irq_en(c);
>> +		}
>=20
> If there is nothing pending, you will leave the spinlock wide open...

you leave it locked...

>=20
>> +	}
>> +	ldma_chan_on(c);
>> +}

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

