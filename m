Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892576BCD4
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjHASpo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjHASpj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FC272E;
        Tue,  1 Aug 2023 11:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F047C61690;
        Tue,  1 Aug 2023 18:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172FDC433C8;
        Tue,  1 Aug 2023 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915526;
        bh=cVb1t9CI5wJTQOk9tSq/YPn/7jPUhs3rsQ0fZi/enYs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fkj62Yvi0Q4bJWWdZH21593B18WyipmOzp7+6DcBbTc5KxKTgm4sRiHmhJ3sjW3m1
         00G8gAKSxImQhFR5VBOEkE/LOxlL7pkVBKWW/gdp0JMdxQkGnJVQNDNRVwnc9oWq5x
         wZ8zBBgbgv4fe3LLPYvCE+tlnaRAQB+FPczB70Y4DsKP01Kk7SOGJl/NjGrlSNpa+U
         1JFv85CdEyeWv23NHhfweR6PiaMCJchq/fANg5KXAjDVRqYaQVO1IwtZUyTCc103Z+
         efoCkvKHSkrYQllc8FvcRP0eAPVeBBWSoTTaw/b8L1pmVoR7Z0KvuqDr/K+K8cpMgk
         vV7GtmlFdviMA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
In-Reply-To: <36fa11d95b448b5f3f1677da41fe35b9e2751427.1690041500.git.christophe.jaillet@wanadoo.fr>
References: <36fa11d95b448b5f3f1677da41fe35b9e2751427.1690041500.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] dmaengine: ep93xx: Use struct_size()
Message-Id: <169091552472.69468.13201647310116428325.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:15:24 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sat, 22 Jul 2023 17:58:40 +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose, more robust and more informative.
> 
> 

Applied, thanks!

[1/1] dmaengine: ep93xx: Use struct_size()
      commit: 926a4b17e9366583142c57e074d8a9e52cadc755

Best regards,
-- 
~Vinod


