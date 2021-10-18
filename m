Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B812243109F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhJRGha (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRGha (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:37:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5B06610A6;
        Mon, 18 Oct 2021 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634538919;
        bh=Ivel0gkQdc/rwmAuBPlMOloqf5Lwmk0Tnh2ftxXr+d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=crhPlcGEEoGhbPTb4WTYXHXVYFf9GFDjJVziJ7A7xTH8FY7kTIRzYy/HtZ0YRMwLx
         lZ8U0lTWKN/gD1fG1jEccc89TZTpkphMLmbj9qgKkUazFKu9dcRLU8qQCxIYxLEhk5
         GrpJNj077e7abZP9d4+hkdtfeHxxcwJJsS3/Vj4L9lqvphmGdNcylfwHdhH1HUeO6s
         VLhBZiEP2/QaE2hC+uovSQ8NdoP7cM5JeYqoOHRt+VKmeertCFVcXhAdi0ib8k/Tfc
         2BLxaSeWJNJZQI6WMxeySJBnb8gVD1q2krpGurwZWvv9nmM/btaecEor+FY5fc6g60
         nc6c1MN7s330w==
Date:   Mon, 18 Oct 2021 12:05:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: check GENCAP config support for gencfg
 register
Message-ID: <YW0VoyTSB2OI0qM9@matsya>
References: <163406171896.1303830.11217958011385656998.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163406171896.1303830.11217958011385656998.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-10-21, 11:01, Dave Jiang wrote:
> DSA spec 1.2 has moved the GENCFG register under the GENCAP configuration
> support with respect to writability. Add check in driver before writing to
> GENCFG register.

Applied, thanks

-- 
~Vinod
