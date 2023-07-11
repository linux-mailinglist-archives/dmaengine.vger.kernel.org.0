Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9574F5EE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGKQpR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjGKQo6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D92706;
        Tue, 11 Jul 2023 09:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095B061582;
        Tue, 11 Jul 2023 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF95DC433C7;
        Tue, 11 Jul 2023 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093852;
        bh=M25TVuQW3nc5OBxJ1n81TAeulJBKRe5upKcf+dcdqfE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e1SXmZ8fiV2JfgyljoRStvsFgPDCa4Ya6Iz5RNppPUYPfGJYoeh+cj7vVD6pmlanU
         41YtOYRQ3Txzm6ZJFd2cLfzPWrFEyb166UlubpAn1PhcZ9sIkG8BhEjCN8qq01f0U6
         +jhMrjRsDyZ4zWMZUACKbchEpAf9UjmLddau4gZVpZ79Rfy7ulE2WmUQHbvw0fUCHX
         Tok29S79mfckTeEXa44DpkgONcikcHxSK0VRni2tfcZKeAuQAENKTzC3Tti81KuwFi
         jGQxxdCX15qZHGkxL+l4ubUStu6BBANC3NOGekEUHlXowToyvucYnr274pcKjdjnHG
         05R6XYD6O84TQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Sean Wang <sean.wang@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230622075150.885-1-johan+linaro@kernel.org>
References: <20230622075150.885-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] dmaengine: mediatek: drop bogus
 pm_runtime_set_active()
Message-Id: <168909384943.208679.9917048623209270134.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:14:09 +0530
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


On Thu, 22 Jun 2023 09:51:50 +0200, Johan Hovold wrote:
> The runtime PM state must be updated while runtime PM is disabled for
> the change to take effect.
> 
> Drop the bogus pm_runtime_set_active() which left the PM state set to
> suspended (as it should be or the clock would not be enabled when the
> device is resumed).
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mediatek: drop bogus pm_runtime_set_active()
      commit: 1775a0d9f021739a69e4cf12c049801c9cf1a072

Best regards,
-- 
~Vinod


