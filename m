Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1860496E
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJSOil (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiJSOi0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:38:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34EA1119D1
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 07:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8705BB8249D
        for <dmaengine@vger.kernel.org>; Wed, 19 Oct 2022 14:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDE1C433D6;
        Wed, 19 Oct 2022 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666189357;
        bh=iMZixcCXnSZa500VXK4XG4O0lGhXCLCt/euF1u+LjB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRXT1kisNn5v/05kETaq0VUvTpCIZqaFN6F/PguHu/yW9xeTL9d1KXTuGM523P7cu
         BInSZ2WML5BFwwG7/VdiuALT3y8FplfhH6HYPa71V6vzSBTBUVPI6clkTm0RkfP7WS
         GUl3BeFxk4IvuaEZqmCiuOtPe9wW13x/85Sv6i5Hz6txlV7kl+9sXfyr8cktKKUd/k
         Fcm2Nu8i5EsI1zso4IzlUOJTJhR3dqFPLlcgAHOMoCdVLdgAKDIrZpmSYy0n9foW/j
         VlgPOIRimOHORDdBwQPmwGLZCon37kA0ujgCI/z+NLDzf8fIilISpikyfxLRXsp8Be
         FaiNCy1c85aPA==
Date:   Wed, 19 Oct 2022 19:52:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fengqian Gao <fengqian.gao@intel.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: Re: [PATCH] dmaengine: idxd: fix RO device state error after been
 disabled/reset
Message-ID: <Y1AIKWC9Ri5vCwQ/@matsya>
References: <20220930032835.2290-1-fengqian.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930032835.2290-1-fengqian.gao@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-09-22, 11:28, Fengqian Gao wrote:
> When IDXD is not configurable, that means its WQ, engine, and group
> configurations cannot be changed. But it can be disabled and its state
> should be set as disabled regardless it's configurable or not.
> 
> Fix this by setting device state IDXD_DEV_DISABLED for read-only device
> as well in idxd_device_clear_state().

Applied, thanks

-- 
~Vinod
