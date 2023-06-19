Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3458F735D46
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFSSH7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFSSH6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 14:07:58 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E7127;
        Mon, 19 Jun 2023 11:07:56 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687198075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Tp0LI/vg6JlukmNhiGcWBsiAqUGGuvYo9ddkoGSkQ8=;
        b=TqUC5G+oG2WZNMdW5APZhi2AEdB2iUJ6cOkSUjSv4dsXItMPY/7hLXGuFgAWL0AA9C1m6O
        NVYkBMiafaZx/Y+BFKc69nmbridg+oN+ogOvlJpnlm5LGN44R9K5dGrHO0IHiOwWvlBluk
        LXyHZ+AmJyrq1he8xnZV9STojd2OCZsWS0qcKZ87OOBtbY/zs6LdZQSp3BlRuFXUDBgFVi
        elF+gMlV/6fk1ggzD34RIh3p6leN41HeT4a7bcwD22922M+9Y0EeCQBgxGHWOFePxOBdtf
        qyhB7Et6w28JtrGPmDzhfAvIUyuKczE6x/CMI7hm+fe010hME2DwiwrroP2e8w==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EE67E0003;
        Mon, 19 Jun 2023 18:07:54 +0000 (UTC)
Date:   Mon, 19 Jun 2023 20:07:53 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/9] dmaengine: dw-edma: Fix the ch_count hdma callback
Message-ID: <20230619200753.242c746d@kmaincent-XPS-13-7390>
In-Reply-To: <20230618210709.rkdjlehyhc7lngam@mobilestation>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-2-kory.maincent@bootlin.com>
        <20230618210709.rkdjlehyhc7lngam@mobilestation>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 19 Jun 2023 00:07:09 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > b/drivers/dma/dw-edma/dw-hdma-v0-core.c index 00b735a0202a..de87ce6b8585
> > 100644 --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -65,18 +65,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
> > =20
> >  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_d=
ir
> > dir) {
> > -	u32 num_ch =3D 0;
> > -	int id;
> > -
> > -	for (id =3D 0; id < HDMA_V0_MAX_NR_CH; id++) {
> > -		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
> > -			num_ch++;
> > -	}
> > -
> > -	if (num_ch > HDMA_V0_MAX_NR_CH)
> > -		num_ch =3D HDMA_V0_MAX_NR_CH;
> > -
> > -	return (u16)num_ch;
> > +	return HDMA_V0_MAX_NR_CH; =20
>=20
> Mainly I am ok with this change. But it would be nice to have a
> comment inlined here of why the number of channels is fixed and that
> the platform is responsible for specifying the real number of channels
> (it's basically what you described in the patch log).

Ok I will, thanks for your review.

K=C3=B6ry
