Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6934FBE59
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiDKOJZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346832AbiDKOJY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 10:09:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF775205E6
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 07:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E567B8160C
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 14:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDA5C385A4;
        Mon, 11 Apr 2022 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649686028;
        bh=Mr9cSZtEgXFDSN2oTk6xxa4RWZnHsTfy3plrVOSxQVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y387+h27aLYLohyuLlGr5NCcKFaPxrReR3rfFN5Nr9I1gZ88uoQPfjpokm9M42ks0
         3PQRu2VbL7z40UJ8NDu0PStfNJASs29GuFn0ludCZUjzBYNXl8/9Jxg8Lv0C50NRno
         AkURCe2lXDc7f295cOUjC/66lbyWbWAHgiAFBzIiXOIl95PrtaXTgsk5yGUVKTA4Iz
         ilCOoopiwlfu5tfhJGX1EwLlkJwS5xyS08Dpq634ccXl6dQaf+KzLzy94k6zrPgF4D
         qFBHdAtuC0jUNNPU29MbdnqDkwut/bPWLID04oGZsZdthFuN8xIO9mcBvW6UXxQdqa
         jXz5eUZdBij3A==
Date:   Mon, 11 Apr 2022 19:37:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, tom.zanussi@linux.intel.com
Subject: Re: [PATCH] dmaengine: idxd: update IAA definitions for user header
Message-ID: <YlQ2B85sM+xOUlgi@matsya>
References: <164704100212.1373038.18362680016033557757.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164704100212.1373038.18362680016033557757.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-03-22, 16:23, Dave Jiang wrote:
> Add additional structure definitions for Intel In-memory Analytics
> Accelerator (IAA/IAX). See specification (1) for more details.

Applied, thanks

-- 
~Vinod
