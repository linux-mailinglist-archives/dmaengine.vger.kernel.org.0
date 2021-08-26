Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5C3F8C4E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243104AbhHZQgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 12:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhHZQgk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Aug 2021 12:36:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74FA660FC0;
        Thu, 26 Aug 2021 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629995752;
        bh=1aT8/QwmjU1tYRicJpg82+xGTbbb3hHxkvrEFjdA5mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3LBq4IsJu99CGIHbCqUkc0t/ISfzTOEU8HL7cz9dFv+NmAfdf5/8J6d7OlHpsMpO
         l1B/x583z0y2H37NzPfIz6SJd8HzwLn5nsjATFkPqVq1E/AwSty3rTxIvaCab68K77
         siPxxJobzr2lFFVUTWstleEHu+6GtE7LUkIkrnZYMwwjd0pnMwhicX+2EEJkDZvpbg
         JvOF2WOLt63sGDMVq6swkeY+sDXijoXnB9kIIJtGLwdhXhJCxG+wApsTlaz0dKHy8l
         x4zleuPKx33O25e/9pyXDE6H0srE/BtrsD/wttl5rTNLSOmljzkI5m5+SqUDdVN9co
         OU+xOnZ9L+UQQ==
Date:   Thu, 26 Aug 2021 22:05:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Baokun Li <libaokun1@huawei.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Fix spelling mistake "faile"
 -> "failed"
Message-ID: <YSfC5GsEtFjxQT9T@matsya>
References: <20210826122500.13743-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826122500.13743-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-08-21, 13:25, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.

Applied, thanks

-- 
~Vinod
