Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01446691851
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjBJGIO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Feb 2023 01:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjBJGIM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Feb 2023 01:08:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF893CE3E;
        Thu,  9 Feb 2023 22:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C1161CBB;
        Fri, 10 Feb 2023 06:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D424C433D2;
        Fri, 10 Feb 2023 06:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676009290;
        bh=RVihfeUWeiL9TtvJUWFsq5wt91c4o/nXVrm2FMNYYRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfRPeP/l5MAG3uW6cX8piZroouBuCbnHg9tP2c48MyRQyOTcR4WwhppCFSKr0BPCA
         XK5o4oTz+djYJ9eN4Bwnaa6IVZRtwXDO77uauyPaqyNXpbcbegSsXgKdgxMC2M2WVM
         wfSt4y3ROwUwnnZoZEn8EyVfaxEkZ4Mw5pmzCWYH6l/E7RcbfdzA9b5S7wWaO6BcQ+
         IGwlmQWo/XDq+DFh79il9XyqOXB8Pba+WdnDt16fZ+BSA7SL1ILXb06brZ3aDGDs8C
         Smu8cj66Ffmqaqub3KW/r+yHzntC/7Ekznd1tHvoOaxf4T1Gl3l5zmXDW9K948oFp5
         XOOMTbh5m22gQ==
Date:   Fri, 10 Feb 2023 11:38:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y+XfRYx2CKsG5/sP@matsya>
References: <20230130111141.59627-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130111141.59627-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-23, 13:11, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

Applied, thanks

-- 
~Vinod
