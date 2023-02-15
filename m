Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0D697A2F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 11:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjBOKtC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 05:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjBOKtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 05:49:02 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19243233D7;
        Wed, 15 Feb 2023 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676458139; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZHe7JolY/BobglmmhQYnFvCdmN/ZLCE2J/uPgfJFoos=;
        b=ix5Z29OKgb6nv2f8ywrwzbbIBABf/26vJCC1rdb3sYWsEob4n0zCkKupmiI7JJWlRYSMRP
        wM4gNVdA69mZHvlUIacLCii0ugFWKJRwGs5EjDrxp7o5vNSuj51olW/yQ/qLnOnzPWoDMx
        WxGMKkxmXlvwHvVEO5PkUgzUStM+QFg=
Message-ID: <53ea4d2db570d3ca514a69015488bd5b849a5193.camel@crapouillou.net>
Subject: Question: partial transfers of DMABUFs
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-media@vger.kernel.org, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 10:48:56 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I am working on adding support for DMABUFs in the IIO subsystem.

One thing we want there, is the ability to specify the number of bytes
to transfer (while still defaulting to the DMABUF size).

Since dma_buf_map_attachment() returns a sg_table, I basically have two
options, and I can't decide which one is the best (or the less ugly):

- Either I add a new API function similar to dmaengine_prep_slave_sg(),
which still takes a scatterlist as argument but also takes the number
of bytes as argument;

- Or I add a function to duplicate the scatterlist and then shrink it
manually, which doesn't sound like a good idea either.

What would be the recommended way?

Cheers,
-Paul
