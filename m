Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5CC74F5D3
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjGKQnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjGKQno (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37D11720;
        Tue, 11 Jul 2023 09:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB29761573;
        Tue, 11 Jul 2023 16:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EE0C433CA;
        Tue, 11 Jul 2023 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093819;
        bh=qCQfbWuEbn8NQE2Rqzc90YvoPipey3ZK3V271DT1K90=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qAGflg0sVxxJwEwb/comoW6zMh/uuMfweLKnpMoeMM+KVH5jIuoZrVP7/lF11Ldv6
         50NGEn4TBKrtl9ng9TQAAhqQGP6znx/268YQ3+1DJ8lsTKoHGHqm+PA2SRP/aMkoBp
         23gxuQNmezWRwUsSYZ/g7NzmURRRrE0Q/aQFcvLG4vyeqEzUbn97TTdwW5BLXrioo+
         33HvVaLwS9k/ONiVair7MJPZJ1fw62kCmebvPxel3Ghd+faV8r8HiVDoVApMSBADDp
         NsXJWW10GMTtpCzZomsJf9c5Eiy6g+N8n+hKY+10Y9mvbba5IeWzjYkvm3/FxXAWGa
         5Wii86KT2wJ+g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <f55d914407c900828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr>
References: <f55d914407c900828f6fad3ea5fa791a5f17b9a4.1685172449.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] dmaengine: mcf-edma: Fix a potential un-allocated
 memory access
Message-Id: <168909381758.208562.7750426998388871956.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 27 May 2023 09:36:31 +0200, Christophe JAILLET wrote:
> When 'mcf_edma' is allocated, some space is allocated for a
> flexible array at the end of the struct. 'chans' item are allocated, that is
> to say 'pdata->dma_channels'.
> 
> Then, this number of item is stored in 'mcf_edma->n_chans'.
> 
> A few lines later, if 'mcf_edma->n_chans' is 0, then a default value of 64
> is set.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mcf-edma: Fix a potential un-allocated memory access
      commit: ad5808c58ddceeab43dc68cc10d99f56d143facd

Best regards,
-- 
~Vinod


