Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3107510EF9
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 04:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357250AbiD0Cvd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 22:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiD0Cvc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 22:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC3D5E83;
        Tue, 26 Apr 2022 19:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BEEF61B54;
        Wed, 27 Apr 2022 02:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE9C385A0;
        Wed, 27 Apr 2022 02:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651027702;
        bh=OKWgD72i9/DkZb5o/GnqIwupnjbeo0SDK1ye7rQFFZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJV67XW2SvSG+yQ02YxQjSf7/x0KsXwXzKAWLBJ26HgSCnfjHO3U837/gnrDpuBPE
         ReJVAcaVTJ9/OmBWUIp7aUA/OycqyJgkxTYaByiqrVb6rHkaxKlvfbPWEmAX5c7qDY
         TRApY/lkeK6JEZiXIZpkMqz46dcB5W4CwwUFoFltBjwOGqoY3s1o/DwahJKI6UOBvT
         sEzNQIIR6yOuVGTlizT5wYTJj8yNrLBnKTs17WpfxUwDuD5QSG83V86Q+YoUyzr0nY
         Xb4rKjsb6orCoMgyP/8FGEa2BkCAcfB8fqk3smZp1K7KIXbocvwGBmSuxbgQZrJ0U+
         FgFGNhz8IP6kA==
Date:   Wed, 27 Apr 2022 08:18:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     sanju.mehta@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ptdma: change pt_tx_status to static
Message-ID: <Ymiu7wF0ky0vEqR7@matsya>
References: <20220423131026.798269-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423131026.798269-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-22, 09:10, Tom Rix wrote:
> Sparse reports thise issue
> ptdma-dmaengine.c:262:1: warning: symbol 'pt_tx_status' was not declared. Should it be static?
> 
> pt_tx_status, like other pt_* functions in ptdam-dmaengine.c, is assigned
> to a function pointer and is not used directly outside of this file.
> So change its storage-class specifier to static.

Patch for this is already in next

-- 
~Vinod
