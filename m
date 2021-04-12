Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A9635BB81
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhDLH53 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 03:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236918AbhDLH52 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 03:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB8D461220;
        Mon, 12 Apr 2021 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618214231;
        bh=XcJ64hW6/8l0/isG67bGEYdvjYS1A7l0QoQmV0j1DKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1GarzLkioqXY/y0bQH8i6LbCgnKf9Cm8TkUk5BQ2Ly067xKN5CzYM1aKtw7YVXXr
         e/Lbtn4nI3vtkgVLmva2zMr5FA+wrDt3o2JPCJXUgHhYJjiDdz5IlNGhlc5tw4V0KO
         jKuVSCWZ+bnE0JpJzERJ7BdDlr7NfDylY0HgNtlg0b7newHZEFIaiT8yAPsY/mtaSE
         RDw5OlFAFlmwS6Kvso+33X6vMWmM6ydHd8ZasaRh/chxfOIF3F1PiD61HYm2FrYWdS
         DPW9E8E9m+gVC5BXOZE0IxxIJhcDNoPqnAHTgjIn24E/bw0x/8xhKe3vV+qS2+tuJo
         zbYpI5v2A++AQ==
Date:   Mon, 12 Apr 2021 13:27:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Lucas Van <lucas.van@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix opcap sysfs attribute output
Message-ID: <YHP9Uvk+oQQsDATI@vkoul-mobl.Dlink>
References: <161645624963.2003736.829798666998490151.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161645624963.2003736.829798666998490151.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-03-21, 16:37, Dave Jiang wrote:
> The operation capability register is 256bits. The current output only
> prints out the first 64bits. Fix to output the entire 256bits. The current
> code omits operation caps from IAX devices.

Applied, thanks

-- 
~Vinod
