Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BA67B1B71
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjI1L4G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1L4F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C340121;
        Thu, 28 Sep 2023 04:56:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A9C433C8;
        Thu, 28 Sep 2023 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902163;
        bh=5PvIM+aPegeroDXqiEYobGZebqOA/gpuCayaIxjoARI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mJze0tmckXpE2hS7/zgZt+kgVdUJNuTPtLBP6W0SJwZtDCyjkiB91BByiIrJJEhNQ
         fOheUCuszQ+gEuL4tmEU1Quxs4YX62EY3W4ceqRw0YyHkTW2sQiWyvxkUiR9b097tr
         7qiW58x700puSXlLKptdZbjPOx8dnNwzhYv8O+FJrp9uLy92AcDpmkdglxq0HC66E1
         J4gIPCgfpPrhYBh7UzH1xuEG3j1tOmSm+QXq1T2bXQnkCZRsMyqYsRdOlZGqWwDOlf
         WtkrSX9JAJCNB4YxrsfDm5A2E8fWdDYxPIdfve33d2GCXQUel9TLxMYpF6KeeruoqB
         9d3swdJmnMynw==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
In-Reply-To: <20230924002347.1117757-1-fenghua.yu@intel.com>
References: <20230924002347.1117757-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: rate limit printk in misc interrupt
 thread
Message-Id: <169590216160.152265.5018881395434400214.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:01 +0530
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


On Sat, 23 Sep 2023 17:23:47 -0700, Fenghua Yu wrote:
> Add rate limit to the dev_warn() call in the misc interrupt thread. This
> limits dmesg getting spammed if a descriptor submitter is spamming bad
> descriptors with invalid completion records and resulting the errors being
> continuously reported by the misc interrupt handling thread.
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: rate limit printk in misc interrupt thread
      commit: 555921feb2ac03d88647ccc62015e68f157c30a2

Best regards,
-- 
~Vinod


