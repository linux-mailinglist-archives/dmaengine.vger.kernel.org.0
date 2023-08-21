Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8E782AE7
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjHUNwJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjHUNwH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72FE3;
        Mon, 21 Aug 2023 06:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A58637E1;
        Mon, 21 Aug 2023 13:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6DEC433C8;
        Mon, 21 Aug 2023 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625920;
        bh=tXlAncwQ5snLHAoPCQYRiKxtAeTDGyGNz79KY8AOJYg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=N7sdohgqPFgNPtdKLKhKMzs5/iraZAio84/Vor5aEp9Bi6LG+lADN50XTasbM6gVS
         EXujHjyFJAzL/vJe9FVmM1x0ih8vap+EZ7rAXo7GPAvsknRge6f3M8rkWHuB+ElGfu
         Fr6I98NM45iHq26WvIbwOA+75J84w7t5Urgw6f/ApA4WyVq/Vde7+jRFtQGiiH2pIG
         yNy0RVLd1mR6fsQJqS9JkUys5vbTs/00I94IAq5YmoUqScTQ/VulOwrbRdLcKX2s6D
         yLHvDI9HGOtC8sxAv/AY+TIHFLOESiZS9+hcxydurQVEAtg+IPe81MktW/QK+M1e2N
         z2GpVSG+T635w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
In-Reply-To: <97c2bb1c9b69d0739da3762a7752ae6582c4ad02.1683390112.git.christophe.jaillet@wanadoo.fr>
References: <97c2bb1c9b69d0739da3762a7752ae6582c4ad02.1683390112.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] dmaengine: mcf-edma: Use struct_size()
Message-Id: <169262591881.224153.14237535666254778689.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:21:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 06 May 2023 18:22:06 +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more informative.
> 
> 'mcf_chan' is now unused and can be removed. In fact, it is shadowed by
> another variable in the 'for' loop below. Keep this one.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mcf-edma: Use struct_size()
      commit: 923b138388928ade722cba86c55145f3dfac1cab

Best regards,
-- 
~Vinod


