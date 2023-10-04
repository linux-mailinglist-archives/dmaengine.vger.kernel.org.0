Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39FB7B7977
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbjJDIEQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJDIEQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 04:04:16 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F9A6;
        Wed,  4 Oct 2023 01:04:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC0E520005;
        Wed,  4 Oct 2023 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696406651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIj6yIoSY7qrnnwvMH3IQDT+/+TNUkJxR+0LKIBkwBQ=;
        b=gsa3ABpEdCKVPn9beVO2oCPX1ZAisPJJ5pDpVHk3iwHROdcVTgZ6+D7/LwW46ir78GNLCt
        dP8OP30wcaMLA60e/a5miUJ5UmudyOi94svq6VLRgH77/Y7w1fpEP+uvn8cAwNyVjPRrtj
        UDSXk6/3fusRt1rTJkhMwBBnXKKaFjGwTn8lFc6VvsxNt/afr7Dj9rEEswqhbZ6ECRbueF
        HA00AIbYE/OB/qmq0uVyoIfPH6LkCp+PywlSC0mwtMGfMIjag35AyNK4qsHY3ry4GlfLwE
        WniaQvFW+XKNc6MCt9Vdt849XxrOiLPmIUBOCaaWumuPoDTWruCZd/dFb/Vvzg==
Date:   Wed, 4 Oct 2023 10:04:10 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 0/5] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20231004100410.5c3c16cc@kmaincent-XPS-13-7390>
In-Reply-To: <ZR0SkhEFe7Cc8p3k@matsya>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
        <ZR0SkhEFe7Cc8p3k@matsya>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 4 Oct 2023 12:51:54 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 02-10-23, 15:17, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > I can only test it in remote HDMA IP setup with single dma transfer, but
> > with these fixes it works properly.
> >=20
> > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > tested only eDMA in remote setup. =20
>=20
> Changes in v2...?

Oops forget to add it to the cover letter, sorry.

Changes in v2:
- Update comments and fix typos.
- Removed patches that tackle hypothetical bug and then were not pertinent.
- Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
