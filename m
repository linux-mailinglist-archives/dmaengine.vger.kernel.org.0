Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2D76BCBF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjHASor (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHASoq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:44:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118BDB;
        Tue,  1 Aug 2023 11:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A1C61680;
        Tue,  1 Aug 2023 18:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C59C433CB;
        Tue,  1 Aug 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915484;
        bh=/TrmjT4bTyWSiHldWLslv4BlOKRS/OItNzfwUm6hP04=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sgs6GhUJTWgUlnE0hO3li3xfYaLWmxKtLwsUjUl+cUtVNzR3eJS+xv48j5pAcDCVF
         byy+OxoPA6vjC/Hil9eDY/8WN5N3WCYFXbX37RJFexm/a1HShf0Rtt6tV5kMPdN9lj
         RBQh7Du4SGa3zAtdjf9QovoEXMH2EZ4Pqcm35CxAWuY9rus7AjK3JmXRLQkzNNmun2
         rwt+ghBXOlLb4YSq6iqzzNUwUd6dch6X12fCMptf45Rc75IDPdgeeOhpO55B0E9MwH
         f5nIfO+LpOPEy/y+PG0AAi23yqy+1gQc3lvxPEdG6OTC3j7kVTBIWViWhkk01hX86b
         C5LHdn/YWFCoQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-serial@vger.kernel.org,
        Robert Baldyga <r.baldyga@samsung.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Richard Tresidder <rtresidd@electromag.com.au>,
        stable@vger.kernel.org
In-Reply-To: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
References: <20230526105434.14959-1-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] dmaengine: pl330: Return DMA_PAUSED when transaction
 is paused
Message-Id: <169091548212.69326.13915666270056885715.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:14:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Fri, 26 May 2023 13:54:34 +0300, Ilpo Järvinen wrote:
> pl330_pause() does not set anything to indicate paused condition which
> causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
> DMA flush after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
> DMA Rx rearm race"). The function comment for pl330_pause() claims
> pause is supported but resume is not which is enough for 8250 DMA flush
> to work as long as DMA status reports DMA_PAUSED when appropriate.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: pl330: Return DMA_PAUSED when transaction is paused
      commit: 85648667b946069b2a3765577c418705c65c2ddf

Best regards,
-- 
~Vinod


