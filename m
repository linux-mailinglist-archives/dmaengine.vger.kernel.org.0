Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5916B2512C
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEUNyR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 09:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfEUNyR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 09:54:17 -0400
Received: from localhost (unknown [106.51.105.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D964521479;
        Tue, 21 May 2019 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558446856;
        bh=mV50Au8ZG+x0O2R6KdtDn2lUTMG7xVfB1PQk8wR02NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSukCtB0J22xf1jquuK8n4kzLvi0Hj8V8hPkzkazkhVxKC9Dsq7QuGcUVKwWzAhv0
         qgD9UlS7JoWOCTsY9fr2yX+7JOYE+FUqTOHCz+6oO8PoAjPQIXNxhqyVjRNxPKNgQZ
         AoeXfqD1YFAO3En1n+4oVVdwQC2wEKHo4VWc9h9E=
Date:   Tue, 21 May 2019 19:24:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Fix some bugs and add new feature for Spreadtrum
 DMA engine
Message-ID: <20190521135411.GM15118@vkoul-mobl>
References: <cover.1557127239.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 15:28, Baolin Wang wrote:
> Hi,
> 
> This patch set fixes some DMA engine bugs and adds interrupt support
> for 2-stage transfer.

Applied all, thanks
-- 
~Vinod
