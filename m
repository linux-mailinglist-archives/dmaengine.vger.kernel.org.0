Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC6E1075
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 05:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfJWDVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 23:21:10 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25467 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJWDVJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 23:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571799928; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lc2NUnikpohM9t0n5cbPB+GRebr6/zx3XKT4rbDRxVBpo2+cWPcjJgf7pPzrWO00DFR/eBEWMKkI9DA87LTZWCR0sXAqG+yEJkIxD22UdTsWXoksgnLzukh7ZyNNn9xnKcNuVRVctmo9FSHtcytterkkHd/iHNfnsgSGY4W0HAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571799928; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=2Uge8+ljj0deMQfYUyYNoqG72JVhhEqn9BRyubJpunA=; 
        b=Nn9z6WmLbgjrm4JHvqZ7zQG/APStL+aWm7BkWOX+D+5BR0mc4jHCw8qPlQSYXN4+lb0dPinUAIeOz/gTsGsRi8kk76Ip+jw0fj0PWUvWNeMDU7ZyXXQ6I7UQwao60tuHFij4LWKfSD1u3WugGFK5cwm9EYx4q6n/LKxU0QOB1/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=Gz57UxplaaMKihRKoF+klm+LbiVEuQaASYP9C3YMZT4DQ7H3k7IFbEii4wgB68eC5nZuFocT+KUM
    gmxFtC5Of/kZisJIrVrjNcd+h8ybYSKAh6DnA3TArPvqloKYnIu3  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571799928;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=138;
        bh=2Uge8+ljj0deMQfYUyYNoqG72JVhhEqn9BRyubJpunA=;
        b=HzWvyEuDWygsE4xWy4QFTzw99wy0jT88unjaldYzpUpl5Fdjnmhst5pSi2/jOW7q
        dwamncQf0dgBfwmD9Px04YzcUXbE33g2YKLENM+tGANo3i4f8YzH0VYtFLjcorCCsVY
        XzCAAwVa/8v20kzDOnVpRBNn/4LoeW9ed0vFMH5U=
Received: from zhouyanjie-virtual-machine.lan (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571799925965485.830652634629; Tue, 22 Oct 2019 20:05:25 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: DMA: JZ4780: Add DMA driver for X1000.
Date:   Wed, 23 Oct 2019 11:05:01 +0800
Message-Id: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1.Add the DMA bindings for the X1000 SoC from Ingenic.
2.Add support for probing the dma-jz4780 driver on the
  X1000 SoC from Ingenic.


