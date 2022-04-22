Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEB50AFFC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiDVGEH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiDVGEG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36EF4F473;
        Thu, 21 Apr 2022 23:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC29B82A80;
        Fri, 22 Apr 2022 06:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB7DC385A0;
        Fri, 22 Apr 2022 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607272;
        bh=3i1HFTIZEG8nOO9HFtaoGnljHf2PsNxcHh/XzjuJJkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jn1BvP4OQKlEKCcLQwC7JsFJCzcCvE4CAA6e6z5kKgZOjsQ8yQhJOoDvAyO8LPeAc
         BL1RuUre/GOA6bBedWs5fsSwxmld8zEN3VkBNDTFZgGtH9XAFKRvHPPmpCPcw7NepO
         ecUecJJiH5oABVTWd/iGyKGmSyso4JjsHlIgTFEnWrO5IEy6Ekm2fFvd35UMtirzWn
         hMQ/CkBN3RxORkEhxumExpf3zKGog/URyzJGXv0lvjsxsY/fbZXuNHHuKwpjXyAJ0f
         3DmKhvimNiLzu6FmQW4EImyUlY0/ct0ko4rnVF8r/+oInwsprm/mzChlC9OohS8yl4
         cmWMzi+6fQaUA==
Date:   Fri, 22 Apr 2022 11:31:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     dmaengine@vger.kernel.org, peter.ujfalusi@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-psil-am62: Update PSIL thread for saul.
Message-ID: <YmJEpMDGqo7eiVgu@matsya>
References: <20220421065323.16378-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421065323.16378-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 12:23, Jayesh Choudhary wrote:
> Correct the RX PSIL thread for sa3ul.

Applied, thanks

-- 
~Vinod
