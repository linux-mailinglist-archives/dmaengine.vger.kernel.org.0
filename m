Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5799438FA3
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhJYGoA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhJYGoA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C56A560EE3;
        Mon, 25 Oct 2021 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144098;
        bh=5HP2iKpfXQZDxRW1mLZGgOjYN6URqlLmNmDuHI3CL3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYbmJBQOH6qvnmp0Yx15Oqzr7Pl6omKGdBdKorVXnEhO5nIQu7Yj/MDWmqCnRp9FZ
         XoYjVK00AVyd80bTqjlDiRZ5wKJI1rS41Odl8XtTQFhrvcnxSV1phhdPuDpeOLHjm/
         awQlHCVkbhd2Ly9Zcc42BTIWsc4JPyvbIZ8su3J23Lci2eq8CyG2ccXShGK9lzJiCQ
         HKaVzBfz0JTKA89gXvqF5oQDlip787ZDBlHys9NPUvvAwrzsxcLeQaiWTghfavwxl3
         HyOloYdxkoW/f742CLbDLi/2ordHx0IwoVODAr0Nmnkpos4bToLQXJgDybS+HaC5LE
         oWEVQm6JSz25g==
Date:   Mon, 25 Oct 2021 12:11:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add halt interrupt support
Message-ID: <YXZRnvtIW88zrfhV@matsya>
References: <163114224352.846654.14334468363464318828.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163114224352.846654.14334468363464318828.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-09-21, 16:04, Dave Jiang wrote:
> Add halt interrupt support. Given that the misc interrupt handler already
> check halt state, the driver just need to run the halt handling code when
> receiving the halt interrupt.

Applied, thanks

-- 
~Vinod
