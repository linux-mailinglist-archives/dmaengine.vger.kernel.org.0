Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9E4D407
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFTQnK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 12:43:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19709 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfFTQnJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 12:43:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bb79b0000>; Thu, 20 Jun 2019 09:43:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 09:43:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 09:43:08 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 16:43:06 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix transfer failure
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1561047348-14413-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bf478236-9aa7-68cc-4a56-296db2fc4379@nvidia.com>
Date:   Thu, 20 Jun 2019 17:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561047348-14413-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561048987; bh=LRAIEKSTmKQE5qE5AvgXkBeRvVsrbSc0H3EL4SfKT80=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YvHD4i52J9zQIZUxt9GAovH9lWLTS+rhcMlPZQARN+5RyGsSsYDop5vfzL7vj8RmI
         ihLcP7FE9Jb4/bW5lNAD1VsTleV/xCf/gsFtI6HxK1TRboLXUbfj8axEloRw+wJ0ru
         YmpaVWMx5YJF68IUz6FlRZplicdZWIFvmGscvmYZaycQeTiPBBc7V80xMihWuIMm+c
         A9wMFBGw4oY+zbRpW2xlJ4qCD1yZoGc8Ewv03NCwm87h2yqZNbzxbx0mo9gXTVEFrH
         yJMelnI72Z+BNjN71GOwsKnsH/7cXxycM6EweXT9x2A8dhNg271D2DVFhKbzYJFplC
         nqDKFGPZhToYQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 20/06/2019 17:15, Sameer Pujar wrote:
> From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
> configuration register (bits 7:4). ADMA allows a maximum of 8 reads
> to source and that many writes to target memory be outstanding at any
> given point of time. If this field is not programmed, DMA transfers
> fail to happen.

BTW, I am not sure I follow the above. You say a max of 8 reads to the
source, however, the field we are programming can have a value of up to
15. So does that mean this field should only be programmed with a max of 8?

Thanks
Jon

-- 
nvpublic
