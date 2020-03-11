Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5318144B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgCKJNV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgCKJNV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:13:21 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2D42146E
        for <dmaengine@vger.kernel.org>; Wed, 11 Mar 2020 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583918000;
        bh=DFnWpo3EG155Iqd5zLHOa/y/FBgsZ7eO/mfpeo0a25Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ThneV3vgwyiITdSHCsfojLNRIWiKu7DjeJEL9tBTrSIifDgQ4EtB4ZnRmnK7bj44X
         Gkrz6Ckbdw99b39WceT8HjfXoe2v/s5ariFDLoJavh3CzBlzXnuafou7yp/XbgZs7J
         HqnTQMIdyZS3oF0I22NnAGhUcVxuqx62a5Zm8Ob0=
Date:   Wed, 11 Mar 2020 14:43:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: move .device_release missing log warning to
 debug level
Message-ID: <20200311091316.GK4885@vkoul-mobl>
References: <20200306135018.2286959-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306135018.2286959-1-vkoul@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-03-20, 19:20, Vinod Koul wrote:
> Dmaengine core warns the drivers registering for missing .device_release
> implementation. The warning is accurate for dmaengine controllers which
> hotplug but not for rest.
> 
> So reduce this to a debug log.

Applied now
-- 
~Vinod
