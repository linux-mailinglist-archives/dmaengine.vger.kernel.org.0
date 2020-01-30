Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4214F14E2D5
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 20:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgA3TAr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 14:00:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3453 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgA3TAq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 14:00:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3327c90001>; Thu, 30 Jan 2020 11:00:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 11:00:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Jan 2020 11:00:45 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 19:00:40 +0000
Subject: Re: [PATCH v6 12/16] dmaengine: tegra-apb: Clean up suspend-resume
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-13-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3507dcb9-4a92-8145-1953-e40960604661@nvidia.com>
Date:   Thu, 30 Jan 2020 19:00:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130043804.32243-13-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580410825; bh=HvbTM3jfPnqdOoL/RKMU1UXf18+E1vc/sKF7YsOBlrg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k277C6/HK3imWn6CinhGpwcNsA6KLB6lPtlKEbQbFJ4CB4krWu2ik+G9Shsu6b1V6
         vPMuFvNlKYrKmaTq1SGMvQU6GudR4qJry+ABdamn1Oi8zfH13ujpqe7he+0a60mk4I
         ZbLOrD1nguYwFAR92/XvwMyjyLLV4A4fba3xjOFASMfivG7cFKwqUDqsqnyivpktUE
         w1MQtUTMMZOD9ummePeKIPRYGXe7s2g2OAgioVnwTUoeUF8Mq1GL7l/37fmlpQT6Jh
         70O4ixhpCv7pPFLEza2Epbwei1x+lacjUTj3H/is7iF81qpfXo5W4KWu/CF48nneYF
         TfU1WtM120LCQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 04:38, Dmitry Osipenko wrote:
> It is enough to check whether hardware is busy on suspend and to reset
> it across of suspend-resume because channel's configuration is fully
> re-programmed on each DMA transaction anyways and because save-restore
> of an active channel won't end up well without pausing transfer prior to
> saving of the state (note that all channels shall be idling at the time of
> suspend, so save-restore is not needed at all).

Maybe just update the commit message to state that the pause callback is
not implemented and channel pause is not supported prior to T114. And
then ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
