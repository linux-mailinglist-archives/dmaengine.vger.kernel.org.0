Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E635245BBF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 06:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgHQEv6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 00:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgHQEv5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 00:51:57 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E045206FA;
        Mon, 17 Aug 2020 04:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597639917;
        bh=GVMbEW7Wl/ZrSbsiJvLcoeOoUi9FXdmO1BZYj5VZn/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7lZZB1DpV+Rn7dUC1FMXkPsPVLK1DaWXOmKpiJ6GrBtfylWgSGGiQOi5VxdtxPLZ
         KDN0uZncydUBmpjubVzy+Fnsr+RxaBjAGefLF5O4p+aiNxGXbpKrtyUYq6fsPvBgfG
         X8u/qDHioPOqB4vnpKYj0r/kTNTUFqqdMxOdSNUE=
Date:   Mon, 17 Aug 2020 10:21:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: acpi: Put the CSRT table after using it
Message-ID: <20200817045152.GB2639@vkoul-mobl>
References: <1595411661-15936-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595411661-15936-1-git-send-email-guohanjun@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-20, 17:54, Hanjun Guo wrote:
> The acpi_get_table() should be coupled with acpi_put_table() if
> the mapped table is not used at runtime to release the table
> mapping, put the CSRT table buf after using it.

Applied, thanks

-- 
~Vinod
