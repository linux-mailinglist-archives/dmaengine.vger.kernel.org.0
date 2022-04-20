Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E807508795
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiDTMBU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378365AbiDTMBT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 08:01:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B921C90B
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30B09B81EB1
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B16BC385A4;
        Wed, 20 Apr 2022 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455910;
        bh=8brG4JDz6ZMGtxmAzMBcQibbBy6MyISvmiNhA4lhnFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxJXEM1I3hBO67P0boTFpvx6BDwlQmDRgFKamGfyPngWnhU0iv8UwsnaJIAFKNtDq
         tQz5GzJRMRCvajBzRW4b+Uf6WG21Go7at3Le3FZn0ieha8vTMJjsX18/rhSvN4Cl0Q
         +XkZCxBNTRyNBw0Ggy60NnS74qV3Qq0D3TOF2ZOlt7S7a8ivM0KPPg2olTO4KHLRB9
         ai8TetC5Ll9XJcEcPlUiWSeS6mNIDEe+HxxzpaTN5oiZVEyrHca+WdwhbQrY5+TMB6
         i6l0wUBYbvUlpI28fuGtLKMXoqedLY65R8bUVDw0Nb4YBBx+6CCx1Fvl0PM5ShFfUZ
         bFLsqBLev9evg==
Date:   Wed, 20 Apr 2022 17:28:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com
Subject: Re: [PATCH v3 0/4] dmaengine: memset clarifications and fixes
Message-ID: <Yl/1Yi4zI6A8yk9b@matsya>
References: <20220301182551.883474-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301182551.883474-1-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-03-22, 11:25, Ben Walker wrote:
> The following contains a clarification for the behavior of the 'value'
> parameter in the memset operation. It is intended to be a single byte
> pattern as laid out here:
> 
> https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/
> 
> Then I'm attempting to fix all places it is currently used. But note
> that I do not have access to this hardware and cannot test it. We'll
> really need a maintainer to take a look at each of these to verify that
> the changes are correct.

Applied, thanks

-- 
~Vinod
