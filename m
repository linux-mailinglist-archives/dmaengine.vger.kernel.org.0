Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8233A1B5540
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDWHOC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 03:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHOC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Apr 2020 03:14:02 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6EB208E4;
        Thu, 23 Apr 2020 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626042;
        bh=J4i9nm6jD/sHQnCmJicrMN/6sF9Zi3+iXaIeq1Sqzc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cONNUBK40/dApO9Rq95W9M+KFsvPcz9TriuyTM7jZ99IoebTRWQ7Oh5+mvOB4Kcac
         zzrQ1S25aZdwaBnXmh+zAhuOB5xN1Hu5LLGdX20ARDI8DgAyxlIZyHVZ0mWJauZNxu
         YBzsuVPpaUpZeWSQZd1m7aBd70BjSMmg1wtKbnFk=
Date:   Thu, 23 Apr 2020 12:43:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dmaengine: mmp_tdma: Drop "mmp_tdma: from error
 messages
Message-ID: <20200423071358.GY72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-3-lkundrak@v3.sk>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> Drop a redundant "mmp_tdma:" from some error messages. The dev_err()
> appends mostly the same thing for us:
> 
>   [  120.756530] mmp-tdma d42a0800.adma: mmp_tdma: unknown burst size.

Applied, thanks

-- 
~Vinod
