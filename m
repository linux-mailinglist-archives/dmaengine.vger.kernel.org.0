Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555A925BB64
	for <lists+dmaengine@lfdr.de>; Thu,  3 Sep 2020 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgICHKj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Sep 2020 03:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgICHKi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Sep 2020 03:10:38 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F309206E7;
        Thu,  3 Sep 2020 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599117038;
        bh=lO2wm3mFGylYDiyVuwxhW4nq6pdy7crDONSAA9yB8Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR7ZSuCSNSagaFYgo/12LthGCRi5tTnl3qK1Oj0E1GX3XDYhSEpFmpeD8CT/G9xqD
         /cUJgOMG+05CLSSKNqV9Dibdk7nGiqve+Q3W5HW2w0tN6vIe2SlJMQFNa8ugEERyK9
         lIUpuZDktwRjoO7168ilSjMjBvVL3MM8lUdcj4Q8=
Date:   Thu, 3 Sep 2020 12:40:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: add command status to idxd sysfs
 attribute
Message-ID: <20200903071034.GJ2639@vkoul-mobl>
References: <159865278770.29455.8026892329182750127.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159865278770.29455.8026892329182750127.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-20, 15:13, Dave Jiang wrote:
> Export admin command status to sysfs attribute in order to allow user to
> retrieve configuration error. Allows user tooling to retrieve the command
> error and provide more user friendly error messages.

Applied, thanks

-- 
~Vinod
