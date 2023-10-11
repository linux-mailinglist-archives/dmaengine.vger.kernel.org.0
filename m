Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7C7C4BA4
	for <lists+dmaengine@lfdr.de>; Wed, 11 Oct 2023 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJKHX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Oct 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjJKHX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 Oct 2023 03:23:57 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB58F;
        Wed, 11 Oct 2023 00:23:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D703AC0008;
        Wed, 11 Oct 2023 07:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697009033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlFUffT8jSN5TarB9jGsVqhpqh8YeMvJSMG5EKL3JgU=;
        b=RYAJ1oVhzqBvHFnA3CVNnRChMl54EPKmD7dzYTAcz4XLT4A+1uSibtl1tzf/9CJzXnBF85
        2x8KA2+0Na5fYfYNOmPV2W9sp+TByw/IWfRFWUMh3KmXSF8sP5P6qqAMaN7BwZLOsCfxop
        anSgqdLU/bipIC7cn6y1wulXd2Tbh1djf1cR8Erc08pXp4VTXt5v08CO6LR7U8YQiHRXv9
        BLKrHjBtdseH3uJD1frdL7EI3LxElb6bd+iwiuIHH3kIgZ0Ruj/xj9nTM1csasV+d3a2/q
        GX4WvOf3gDRsx0uWTbNJwhDEOf2g3qTBfLk+tMAQPYByGAirO7mi1d8ZDH3/Zw==
Date:   Wed, 11 Oct 2023 09:23:50 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Typos fixes
Message-ID: <20231011092350.18049672@kmaincent-XPS-13-7390>
In-Reply-To: <20231010145906.GL4884@thinkpad>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
        <20231002131749.2977952-3-kory.maincent@bootlin.com>
        <20231010145906.GL4884@thinkpad>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 10 Oct 2023 20:29:06 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> On Mon, Oct 02, 2023 at 03:17:46PM +0200, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error.
> > Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the =
STOP
> > bit is already set in the same line.
> >  =20
>=20
> You should split this into two patches. First one is a typo and is harmle=
ss,
> but the second is a _bug_.

Thanks for your review.
Ok I will do so.
Serge if it is ok for you I will keep your reviewed by on the two separate
patches.
