Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D076BCCC
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHASp2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjHASp0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3812D66;
        Tue,  1 Aug 2023 11:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6EF6168D;
        Tue,  1 Aug 2023 18:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7848C433C8;
        Tue,  1 Aug 2023 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915506;
        bh=sgAK1JvUuCPpF/PkpSM1IeVHtAvLPrrTTC8vx8G4ef4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gWJ7Bn6Is9DT/1d26qOt0om2fjPJbyduAg/BUUOnaojsMfILZTTpVK2JIo0u5Qd5J
         MMH/il9+9FqaW95XbiS9MDMcVE65wb2jbvgnHrdotks8lKYvHtntKy39K8vGOyWsvk
         4laQQu9Q1a/ynQKqF9ixmrgTTkrBirr+8pTXbxA3W6JGzBoaap9/F/VpIkgZUf8Nmb
         7PF2qnGFDQsK6jYWxEEg9TraJh8M+LjgOVOyPRBlRXTseygcB8yB5En/1FUa2yTH4g
         8GdmgWcg5xZWIdFhpWKFTIanaTiwaGkKXKBrAH8HEuCHo2bqoe1moNtjwvMkM6HG0B
         UMfsU3+nwzkfQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230703145346.5206-1-ubizjak@gmail.com>
References: <20230703145346.5206-1-ubizjak@gmail.com>
Subject: Re: [PATCH] dmaengine:idxd: Use local64_try_cmpxchg in
 perfmon_pmu_event_update
Message-Id: <169091550434.69468.5073669723336926533.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:15:04 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 03 Jul 2023 16:52:37 +0200, Uros Bizjak wrote:
> Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
> in perfmon_pmu_event_update.  x86 CMPXCHG instruction returns success in
> ZF flag, so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
> 
> [...]

Applied, thanks!

[1/1] dmaengine:idxd: Use local64_try_cmpxchg in perfmon_pmu_event_update
      commit: cae701b9ccf128edea26982f73178087fc3ad180

Best regards,
-- 
~Vinod


