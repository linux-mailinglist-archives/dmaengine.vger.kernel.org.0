Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2012AF48
	for <lists+dmaengine@lfdr.de>; Thu, 26 Dec 2019 23:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZWaa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Dec 2019 17:30:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34626 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZWaa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Dec 2019 17:30:30 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so24320366iof.1;
        Thu, 26 Dec 2019 14:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oXj0egOLEipXvK+Cz50CdkjFGq0EgLBghdmBZ/5exkA=;
        b=BaM0Kv9PitrssQO4/B6aM9d1d2nm86iTYsvEAFl43U2yJ+W7z2dteG4zllHXMzH+Gy
         E9gpMYNbg1shBDkfqlqJNLXxt9BtgnjChgh8j/0DMLtX4RRPWvq0JJgWDxM5oC0zP3tj
         HviaSLP8+HUEJ51IJSjmZJ6oBb2/qsMtYqohZNyL6zk8aYYPQBi3UvDGY8JbN1eiSTCs
         JTx4LOpb4C7FfBDJkKJx97v8CC975hLm4L07JjEcIOCnO9vUks9t+kO0LL5A9cdgzRwD
         jU5d1f+mTRbyC4gESq4AcGR4Tz7pmZj4mr96f6dLMUh2pvK8liwuQzcKLrWWx3CKjS6a
         KC8A==
X-Gm-Message-State: APjAAAXXmMeAtRHeeX/4OUGZMg6lIqgzwAS7qQTz/1T6grl1CFFnUjOB
        TM1h5sevwPIFgWc0qZLlXg==
X-Google-Smtp-Source: APXvYqybilZELhr0wxtYJ1otx4J19UA6rDSIOcsvRrEk+czzp4qNmJFh99eChtoX3LmtuL9hvrlJFg==
X-Received: by 2002:a5e:8b06:: with SMTP id g6mr31032706iok.61.1577399429555;
        Thu, 26 Dec 2019 14:30:29 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t88sm12617185ill.51.2019.12.26.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:30:28 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:30:27 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net, vkoul@kernel.org,
        Zubair.Kakakhel@imgtec.com, dan.j.williams@intel.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add X1830 bindings.
Message-ID: <20191226223027.GA29959@bogus>
References: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1576591140-125668-3-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576591140-125668-3-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 17 Dec 2019 21:58:59 +0800, =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=          wrote:
> Add the dmaengine bindings for the X1830 Soc from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  .../devicetree/bindings/dma/jz4780-dma.txt         |  6 ++--
>  include/dt-bindings/dma/x1830-dma.h                | 39 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/dma/x1830-dma.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
