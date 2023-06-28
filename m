Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3B740FE9
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jun 2023 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF1LQv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jun 2023 07:16:51 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17592 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjF1LQe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jun 2023 07:16:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1687950982; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZZlgzUq5NUHrka0aoshbot51CpzuDpBdy+XKtPamjnL6D3ELRZ6OoL+v7Hz3pc3OFtC8dIogwpwk7zQYisPvWLZ0wr1WEEVbUHnKJWKcF9HeX9I9IDQ8WJx4gbPx7g1N6RP3eTNTPKNXzgNKvsgQzAQsEXGOh8c/53IxYcGtmhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1687950982; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=FITWfOQSLZcRm2X7I99mXdDRUnYkfYJapAY6VqQhFJU=; 
        b=mLv3uoGKqAUOcGGffN8hYILcMhxAIpkWusuqhFJONMcAZ05qu7RM91xcaLOL9CCTbgqS0BqUQZlJJtqT4j7LmR5x/8Ih/F70APpuzcgPphoMfYz3XyNwknjR69SlRl4bdUoCTyK2jBjsVcBVA+yvNKb4hKBFVzLayg5eu0wW40Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687950982;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=FITWfOQSLZcRm2X7I99mXdDRUnYkfYJapAY6VqQhFJU=;
        b=QIUXc/SIzOT1F8TwSXJNZYa/yUpPTWoRaop0FQVtqJ7zfTlfrznHaZYf/FE61mKh
        gs08M1fSWXTG+2+BMp37OFFv9jboZiFTHkNXtfoshlZlD0M/nARP68PFSNKj/89KT9l
        6mqDXsbs3WCgh5C06ZsEsc7TEeNJFPU8WWlxndRc=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1687950981133598.4605502910363; Wed, 28 Jun 2023 04:16:21 -0700 (PDT)
Date:   Wed, 28 Jun 2023 19:16:21 +0800
From:   Li Chen <me@linux.beauty>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "dmaengine" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Message-ID: <18901b7f7f4.10c6f89c4692094.481698950513259776@linux.beauty>
In-Reply-To: <ZJwTV59xRlUBit+N@shell.armlinux.org.uk>
References: <18901a6cbf0.c9e3e099688173.4166132371304083225@linux.beauty> <ZJwTV59xRlUBit+N@shell.armlinux.org.uk>
Subject: Re: Should dma_map_single take the dma controller or its consumer
 as an argument?
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Russell,

 ---- On Wed, 28 Jun 2023 19:02:47 +0800  Russell King (Oracle)  wrote --- 
 > On Wed, Jun 28, 2023 at 06:57:35PM +0800, Li Chen wrote:
 > > Hi all,
 > > 
 > > I recently encountered an issue where the dma_mask was set in the DMA controller's driver, but the consumer peripheral driver didn't set its own dma_mask.
 > 
 > It should always take the device that is *actually* performing the DMA,
 > since that is the device that has restrictions on what addresses can be
 > accessed, etc.
 > 
 > Devices that "consume" the data from a DMA controller don't access
 > memory - they are merely the targets, and they can't on their own access
 > host memory. Therefore, their dma mask _should_ be irrelevant.

Thanks for your quick response. Therefore, I just need to use chan->device->dev in my dma_map_single and there is no need to configure the dma_mask for my consumer peripherals.

Regards,
Li
