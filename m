Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128C414DC85
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA3OJr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:09:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15390 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OJr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:09:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32e3760000>; Thu, 30 Jan 2020 06:08:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 06:09:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 06:09:46 -0800
Received: from [10.26.11.91] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 14:09:44 +0000
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
Message-ID: <e787bee2-4b52-1643-b3a5-8c4e70f6fdca@nvidia.com>
Date:   Thu, 30 Jan 2020 14:09:41 +0000
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
        t=1580393335; bh=senWrEFj3zdIo7s6cZjVMOCga/bYlHRoVltSZ82rcI8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p3NP+bz5dLTiUrhGqKj7vkUTRuaj9DgTLOzM04KEzAR/I3DsgDgiYeaMDB9efpAco
         b3xXdoW43rXvG1eOxl8dUz1eYnKA4dC7A4J/9T6OYrRQd6I28B6aHFF0vQsSMFm87V
         pWBJS4WvhuFTtt4wzJYfUxtil9ENGAlZ/1skdpwo1gGziNif67vzf4VacG+20GRYnF
         axakdTlKTV8V8e01V5o+pH1PBFOIa91ZSwczhczDfSwxJE5pUdgeeOMjgyl/iERMOn
         JsmMBc3XaeuTSUIXiTzqTWn0L/EDsnBWNMxP5/B+Dm89MFLBgKEud2mAYiAtP/uqSQ
         BwNMTatvWHxtQ==
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

I guess if we ever wanted to support SNDRV_PCM_INFO_PAUSE for audio and
support the pause callback, then saving and restoring the channels could
be needed. Right now I believe that it will just terminate_all transfers
for audio on entering suspend. Any value in keeping this?

Jon

-- 
nvpublic
