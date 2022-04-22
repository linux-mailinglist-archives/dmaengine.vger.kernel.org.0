Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5676850B007
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiDVGDP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiDVGDN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:03:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AEC4F9E6;
        Thu, 21 Apr 2022 23:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADB47CE2734;
        Fri, 22 Apr 2022 06:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4547BC385A9;
        Fri, 22 Apr 2022 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607215;
        bh=np9k1HF17G/foQYsLsraNIRu3iRUQ1M7X1InLfXJuQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkR4he/6UBUNRftk8d8Y87Wt3vDwtiOj7zEDz7HWFoOW8uBFx9llbDR5pg30bUVBu
         S1gJ1GbZyGzH0PG20DDLem56Geq0S2/LxxHL0WcHCH937FXgN+a7GL+U30V+tFCMTQ
         PcKR7A1FhbhbnmjtxPhFLDAqP9uRqqYoG2OdyIH18qBa8nKK//ZHRbDcJrnn5U8v44
         ndM5gtQ1GoeC87V0FmiEMPJoNbPUeSuOWDxlEtDN/AoHUNJLrjEgnw/0/SA+6hqdCc
         HeU1Vr2L0F1TY2MDkTMxo2WXcNUcv7HivQ+i03wGZdafqgL/XK5BDMKzzXhOrfWY+o
         ZidfbTW6EupQw==
Date:   Fri, 22 Apr 2022 11:30:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     i.m.novikov@yadro.com
Cc:     sanju.mehta@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@yadro.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: PTDMA: statify pt_tx_status
Message-ID: <YmJEa8YH4vI1G38s@matsya>
References: <20220421092143.18281-1-i.m.novikov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421092143.18281-1-i.m.novikov@yadro.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 12:21, i.m.novikov@yadro.com wrote:
> From: Ilya Novikov <i.m.novikov@yadro.com>
> 
> LKP bot reports a new warning:
> Warning:
> drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous
> prototype for 'pt_tx_status' [-Wmissing-prototypes]

I have applied 20220421052407.745637-1-vkoul@kernel.org which was sent
before this

-- 
~Vinod
