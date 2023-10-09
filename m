Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218B7BD313
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbjJIGMT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345173AbjJIGMS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E30A4;
        Sun,  8 Oct 2023 23:12:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCE1C433CA;
        Mon,  9 Oct 2023 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831937;
        bh=FTNOXpa65H/cSqigLsrU9/tvUHcGMrJuoHxbZJutJa8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dqWM+5MZqoUaGuyBCCy0tnTXdOwqal2FpQ2R8vdT92eBmht1UsZX6gnPTT+cyeDJv
         DrWg5TGEZDgg81bfklvh9WpewY+gPezRmgN7Hhdn9q3/xrqp3yPwyFf1X7+seOCU+J
         VJNqSNY7hkkSXcXnntiyo2qyh1ym+l6Q5ajXo31TpUuAWGmGVB7ocWSNz+UNh9SHav
         PmBIMeRrs6PDY3sYngGZ/vgPIDLM6cZCWqx45ngk0Zz9skzbKXk70orlxIyQh8ILH0
         ah8psLqd258l0ZUzl0smrZieCFHkFfDRiWqvw6ddeF5YGEJAtsG9n3UVb9X23YP6eb
         22LnrVkmat2Ww==
From:   Vinod Koul <vkoul@kernel.org>
To:     keescook@chromium.org, gustavoars@kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
In-Reply-To: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
References: <c8fc5563c9593c914fde41f0f7d1489a21b45a9a.1696676782.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON()
 in pxad_free_desc()
Message-Id: <169683193345.43997.16902412199226518649.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 07 Oct 2023 13:13:09 +0200, Christophe JAILLET wrote:
> If pxad_alloc_desc() fails on the first dma_pool_alloc() call, then
> sw_desc->nb_desc is zero.
> In such a case pxad_free_desc() is called and it will BUG_ON().
> 
> Remove this erroneous BUG_ON().
> 
> It is also useless, because if "sw_desc->nb_desc == 0", then, on the first
> iteration of the for loop, i is -1 and the loop will not be executed.
> (both i and sw_desc->nb_desc are 'int')
> 
> [...]

Applied, thanks!

[1/2] dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      commit: 83c761f568733277ce1f7eb9dc9e890649c29a8c
[2/2] dmaengine: pxa_dma: Annotate struct pxad_desc_sw with __counted_by
      commit: 0481291f0ccbc5147635cf0eb108f9fe5a05ee7d

Best regards,
-- 
~Vinod


