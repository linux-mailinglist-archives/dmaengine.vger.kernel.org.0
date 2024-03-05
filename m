Return-Path: <dmaengine+bounces-1258-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C58715C8
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58052B22797
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF87D09D;
	Tue,  5 Mar 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="aA6RsbfO"
X-Original-To: dmaengine@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6F7C6C0
	for <dmaengine@vger.kernel.org>; Tue,  5 Mar 2024 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619639; cv=none; b=FNbXVT1GYrKb/4sgZuwB8AY3KLf0WtgSfrSOFow4JXWs9HtUUDOYUdawOqMYGZYPunlwUp8xEC4x702Y1gNXD4EJXF46LkIix5b7emTXaWFhVYyFZK2cKN+CFYaenovH4kP5lyFyKtal/tN/PpSZJJpXsRhYY5kS1+Ds+GXZfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619639; c=relaxed/simple;
	bh=RDc2FgK9KBEAoEybt2cK76Njw4wXKy3QNd6y2peeaIE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NcJvOhQEzQts8MwZmZN3T98rnWbO4KLNohcCDfX0F8Ces7qyEAYk01pkVwqKQrKP2yrOUU7AO4jkYnXCzsGhZ8Jdw4F6GxD45/4ZSwPAyBfl7eSkV9pcGU6/1phLC7He66YH9uTZCOQZfpp3pkLvLefBLFH6CH9Mt5LGKHwwB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=aA6RsbfO; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id hG2frVDCDDI6fhOAGrRU5U; Tue, 05 Mar 2024 06:20:36 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hOABrkd884W2PhOAEr8ElM; Tue, 05 Mar 2024 06:20:35 +0000
X-Authority-Analysis: v=2.4 cv=RYWWCUtv c=1 sm=1 tr=0 ts=65e6b9b3
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=oz0wMknONp8A:10 a=hD80L64hAAAA:8
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=LywAyCD41A-1GUSnf9cA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VUyE2CiKhsfUXFjkUTpgRFfJaUNoDyxfOrTQvJ6ukKc=; b=aA6RsbfOajw6u/Q+b719qtWWve
	j7DzUOMiahS7+wiMZ7GxnrG29K1nooZD+tey/3ozbFNmEBcQmrSdr8YuYU7IYjJB8wUxu1nzQwXmL
	JPsmY5BV4oyO9hrwgrMHRU1Q+S4GPRGON6J38cljVnzOvADNlBYz0fOakGwW7yEsQuLxF4wWDT84v
	wY6EUo16Skc3dZ6/Z5cZxWJi4TY8+xpV19ZU2nsRHAq2NPFa1bUHfwBeDRo/9heAfVZwac3Uc0Kz1
	3lCZshjuo8b38286ANAl5QuWzvWprMlV8XuEJTVnBW9Z0kdk5PqghafQrMFAkqAcGUQcv0H6MleFl
	kFokNYkA==;
Received: from [122.165.245.213] (port=54194 helo=[192.168.1.21])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1rhOAA-002kMF-03;
	Tue, 05 Mar 2024 11:50:30 +0530
Message-ID: <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
Date: Tue, 5 Mar 2024 11:50:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: vkoul@kernel.org, bumyong.lee@samsung.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com
From: karthikeyan <karthikeyan@linumiz.com>
Subject: dmaengine: CPU stalls while loading bluetooth module
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1rhOAA-002kMF-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.21]) [122.165.245.213]:54194
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 2
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNgDR8obAKfE0i9bXgENurzB/t72HO6KI9jDFreOvVZH5vv9IBm/2mIebm/998Z1xYCgooY9jxRbCFv9p7LCZrk/knKtpv/k2YfK622NUy2P6tQzLwkP
 tkeqYRexMTVEDNTQxDGqagOKaQVv7P97Ua5xD1wPss7gopwupjJB8pe6uOrJZt7eojfzHigh00qWGQCfOPcxQ7JwfsV12ET/ZZ8=

Hi all,

we have encountered CPU stalls in mainline kernel while loading the 
bluetooth module. We have custom board based on rockchip rv1109 soc
and there is bluetooth chipset of relatek 8821cs. CPU is stalls  while 
realtek 8821cs module.

Bug/Regression:
In current mainline, we found CPU is stalls when we load bluetooth 
module. git bisect shows commit 22a9d9585812440211b0b34a6bc02ade62314be4 
as a bad, which produce CPU stalls.

git show 22a9d9585812440211b0b34a6bc02ade62314be4
commit 22a9d9585812440211b0b34a6bc02ade62314be4
Author: Bumyong Lee <bumyong.lee@samsung.com>
Date:   Tue Dec 19 14:50:26 2023 +0900

     dmaengine: pl330: issue_pending waits until WFP state

     According to DMA-330 errata notice[1] 71930, DMAKILL
     cannot clear internal signal, named pipeline_req_active.
     it makes that pl330 would wait forever in WFP state
     although dma already send dma request if pl330 gets
     dma request before entering WFP state.

     The errata suggests that polling until entering WFP state
     as workaround and then peripherals allows to issue dma request.

     [1]: https://developer.arm.com/documentation/genc008428/latest

     Signed-off-by: Bumyong Lee <bumyong.lee@samsung.com>
     Link: 
https://lore.kernel.org/r/20231219055026.118695-1-bumyong.lee@samsung.com
     Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3cf0b38387ae..c29744bfdf2c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1053,6 +1053,9 @@ static bool _trigger(struct pl330_thread *thrd)

         thrd->req_running = idx;

+       if (desc->rqtype == DMA_MEM_TO_DEV || desc->rqtype == 
DMA_DEV_TO_MEM)
+               UNTIL(thrd, PL330_STATE_WFP);
+
         return true;
  }

By reverting this commit, we have success in loading of bluetooth module.


Output of CPU stalls:
# modprobe hci_uart
[   27.024749] Bluetooth: HCI UART driver ver 2.3
[   27.025284] Bluetooth: HCI UART protocol Three-wire (H5) registered
# [   28.125338] dwmmc_rockchip ffc70000.mmc: Unexpected interrupt latency
[   33.245339] dwmmc_rockchip ffc50000.mmc: Unexpected interrupt latency
[  326.195321] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  326.195880] rcu:     0-...0: (3 ticks this GP) idle=e5f4/1/0x40000000 
softirq=551/552 fqs=420
[  326.196621] rcu:              hardirqs   softirqs   csw/system
[  326.197115] rcu:      number:        0          0            0
[  326.197612] rcu:     cputime:        0          0            0   ==> 
10500(ms)
[  326.198231] rcu:     (detected by 1, t=2105 jiffies, g=-455, q=17 
ncpus=2)
[  326.198823] Sending NMI from CPU 1 to CPUs 0:

Expected Output:
# modprobe hci_uart
[   30.690321] Bluetooth: HCI UART driver ver 2.3
[   30.690852] Bluetooth: HCI UART protocol Three-wire (H5) registered
# [   31.453586] Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c 
lmp_ver=08 lmp_subver=8821
[   31.458061] Bluetooth: hci0: RTL: rom_version status=0 version=1
[   31.458608] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821cs_fw.bin
[   31.465029] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821cs_config.bin
[   31.483926] Bluetooth: hci0: RTL: cfg_sz 25, total sz 36953
[   32.213105] Bluetooth: hci0: RTL: fw version 0x75b8f098
[   32.274216] Bluetooth: MGMT ver 1.22
[   32.285376] NET: Registered PF_ALG protocol family

Thanks,
Karthikeyan K

