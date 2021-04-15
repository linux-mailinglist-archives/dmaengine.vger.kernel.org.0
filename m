Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B63602ED
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 09:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhDOHGx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 03:06:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:51512 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOHGw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 03:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=GpPC6kjMAScPgOy9gWmvzAqvitQWMheOac8bf5AM7OU=; b=MVjRdroWh7p90PFc+51tvIkr9K
        5rF2ufksBnKBAKF/7NjjzvDgkpaf02c0VwzlLVv+C37KTg05jtSr4V4dz5fZRhDJicdJvfaZqYH7g
        ni6MvHdyScuSCU1sLgyTCO6fh2H7CzQDXYeUCGNriJH53TNR6uw9dzAaAMyHVMIstZbwB60x5iMzS
        FN/fg0UoS6uLdyxmOM+CImCns1dG55lSo0JOJxr3us/TggXzEUZFI0iZAt57cla95avOHwXyr8IXm
        pi7DXOixVkneDuCsYuwNqsO8VeTvpxMHvUnIDhQh38qs1s+Aoqf/2d7xfZ9RdclMjWnqHROjojIiw
        X6fsCtuA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWw54-000Chl-Lw; Thu, 15 Apr 2021 09:06:26 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWw54-0003pF-B1; Thu, 15 Apr 2021 09:06:26 +0200
Subject: Re: [RFC v2 PATCH 0/7] Xilinx DMA enhancements and optimization
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        vkoul@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0948eae0-b304-79f8-7d9a-543cba78fbe5@metafoo.de>
Date:   Thu, 15 Apr 2021 09:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26140/Wed Apr 14 13:10:01 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/9/21 7:55 PM, Radhey Shyam Pandey wrote:
> Some background about the patch series: Xilinx Axi Ethernet device driver
> (xilinx_axienet_main.c) currently has axi-dma code inside it. The goal
> is to refactor axiethernet driver and use existing AXI DMA driver using
> DMAEngine API.

This is pretty neat! Do you have the patches that modify the AXI 
Ethernet driver in a public tree somewhere, so this series can be seen 
in context?

