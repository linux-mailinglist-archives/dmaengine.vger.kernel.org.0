Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126B1484ECE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 08:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiAEHmM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 02:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiAEHmM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 02:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0AC061761;
        Tue,  4 Jan 2022 23:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11150B817C3;
        Wed,  5 Jan 2022 07:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3385C36AE3;
        Wed,  5 Jan 2022 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368528;
        bh=tah8ZqyBAPZaiCsGR/M7lDgq65lnx8P0HIpYzkp1OAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+xIeEvpxk1HyE4dK03D8OWKAw9JGc4CmN2fB3QZZag1mXjZzNmzvFqyLzGiLJ+gp
         m4+1FYpIhE+r750F785Kdk0s0rvprxFx+JWiIO1CUFe6/W7BYW+vjyIvp9YEq/9OYt
         +lqFUnS+LgBKtmMKfHqlm9NzNTWjwBGcxsKhob/pws0ju+5nKMEuLK4yi7p6x2yCHT
         db2KHh6NHVW1thwOoD4hhusg+Dx6ORLisFgwW8r+0PvgpmHrV/Hz8JhaPpepb4BICs
         SWR5xNJ6OUfVtqhZk4JpeG+1gpNJ90EZELv7cIvVBA86evx6//9IghYxYrv9jY/UVX
         fnejhvCPwcSWg==
Date:   Wed, 5 Jan 2022 13:12:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ioatdma: use default_groups in kobj_type
Message-ID: <YdVLzCAtiZHfdhn9@matsya>
References: <20220104163330.1338824-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104163330.1338824-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-01-22, 17:33, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ioatdma sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.

Applied, thanks

-- 
~Vinod
