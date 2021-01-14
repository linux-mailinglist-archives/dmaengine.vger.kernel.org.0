Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04582F5E65
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jan 2021 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbhANKL4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Jan 2021 05:11:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13023 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANKLz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Jan 2021 05:11:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600018c30001>; Thu, 14 Jan 2021 02:11:15 -0800
Received: from [10.26.73.78] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 10:11:05 +0000
Subject: Re: [Patch v2 0/4] Add Nvidia Tegra GPC-DMA driver
To:     Rajesh Gumasta <rgumasta@nvidia.com>, <ldewangan@nvidia.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kyarlagadda@nvidia.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2a99ca73-a6e8-bf7d-a5c1-fa64eee62e23@nvidia.com>
Date:   Thu, 14 Jan 2021 10:11:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610619075; bh=6Gd6/P0+ZIo5rz3K14Hcw7eWfVK4wN0/A12MiyJAgHw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=bGkJKPtTEMDKqIeOEhduvYJNT9XZy/pxujSvG7RL1QI/p7xAxx1enVIVpJ1c7vaRk
         90WzpQZV0viUwm7jmmfoHkZRJ8eowmWovXLKuAJFE2SxzQCg8ThsViJBf4MIZQfbvH
         sybfSgwLF4brslEYINrWSW5FvP4a34U/gz7sEfQffTL0gzdUD7blJmRF5s4uzqi54u
         Y2yrEEPAh6cDddDbh/z0EwL5qx7lq90c5KAZci/eUNNPXm7gQ6yYTe2AauPuK9RuZ3
         60sWX0THgrd3l6m+dAUvqa9A/3IeUABAcIy785DYBPx5JumxMCjfgacaxvW1IjIM3r
         bpSeueqMKhQpA==
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/08/2020 08:30, Rajesh Gumasta wrote:
> Changes in patch v2:
> Addressed review comments in patch v1


Is there any update on this series? Would be good to get this upstream.

Jon

-- 
nvpublic
