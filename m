Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8009360302
	for <lists+dmaengine@lfdr.de>; Thu, 15 Apr 2021 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhDOHLV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Apr 2021 03:11:21 -0400
Received: from www381.your-server.de ([78.46.137.84]:59882 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhDOHLU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Apr 2021 03:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=XZuEordCFg9usJz8+FV+eiuBoQwGRAcvkHRboLDO42Q=; b=ED+HWLkvpMupUqrMJPwU+vZI7P
        z6HxsJQPmCLvc95nQuWmyr+d7O4uy0TJSMtnLwNytCASFX5J5/Uv/ilAdQvKxXtd7uDqWHGbUjuyz
        pVbZaJQoHCEOBb2HYnHoVp4sh9TV6V08ux6BAzpbPHrMqISODus8BjpR6TGQbwZ6VrfvnVENDjzyA
        0mBJL/FVq3l/lPmblSxcz6etnAHBZPr5sryi7LG8rbGL08Q1Y+k00v35XOjgbnFUdtC8FPEyvWqQ9
        QtjMGAzpXgS632L++4mlcY3lY3ZgcUOwF+NFfih4FaQxgV29e9LE/X0BMFpdOaRq7lbbb01XFt5mR
        KvrR+8ZQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWw9O-000DSu-Uy; Thu, 15 Apr 2021 09:10:54 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWw9O-000PxL-PH; Thu, 15 Apr 2021 09:10:54 +0200
Subject: Re: [RFC v2 PATCH 6/7] dmaengine: xilinx_dma: Use tasklet_hi_schedule
 for timing critical usecase
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        vkoul@kernel.org, robh+dt@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-7-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <52f01459-13be-ff29-1c07-b98636169c74@metafoo.de>
Date:   Thu, 15 Apr 2021 09:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617990965-35337-7-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26140/Wed Apr 14 13:10:01 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/9/21 7:56 PM, Radhey Shyam Pandey wrote:
> Schedule tasklet with high priority to ensure that callback processing
> is prioritized. It improves throughput for netdev dma clients.
Do you have specific numbers on the throughput improvement?
