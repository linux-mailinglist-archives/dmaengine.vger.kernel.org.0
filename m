Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C4657365
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiL1G43 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiL1G42 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B768BCA;
        Tue, 27 Dec 2022 22:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7102612EA;
        Wed, 28 Dec 2022 06:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B42C433EF;
        Wed, 28 Dec 2022 06:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672210585;
        bh=HQlLPRUCV5V2aeglJVM6vkaSy1un22Arm6s/UT8f8Fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JU07QjIe2kfJzwSZH10caPU45FEH4B9CZ9PV03s7VXV68+wcydPTiL/3H4W89dFB4
         i/PfO28DKJ8rl41cFyrRDEq1t85BZNcNj3LXljidILOP1bQMTxOUyX4bzs63UI082R
         77I/Cpa9ZOPrgXk2X2r61AAFawZtcQ1gvEK/1VxO8J+Ttb2hqxKXPNKUj+Ig8QGDFs
         6k/HvgOO8/GgXVYiC5ZjZUjwrp2zIM0+/Vire1r/ixvaqX7Mn3lt4NaA/ZMTJxce2t
         oDBZbdMmH40e8oCQTf3u4rxRLvltYvCRd+eFetLpZRuplFiwqTVcN1tZmATzG457Rv
         iV6+JwjuDWNFA==
Date:   Wed, 28 Dec 2022 12:26:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Subject: Re: [V2] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx
 operation
Message-ID: <Y6volLcIST8bKv1u@matsya>
References: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-22, 23:08, Vijaya Krishna Nivarthi wrote:
> Rx operation on SPI GSI DMA is currently not working.
> As per GSI spec, link_rx bit is to be set on GO TRE on tx
> channel whenever there is going to be a DMA TRE on rx
> channel. This is currently set for duplex operation only.
> 
> Set the bit for rx operation as well.
> This is part of changes required to bring up Rx.

Applied, thanks

-- 
~Vinod
