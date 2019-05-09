Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2418DE4
	for <lists+dmaengine@lfdr.de>; Thu,  9 May 2019 18:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfEIQUv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 May 2019 12:20:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38645 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfEIQUu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 May 2019 12:20:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so2544971ljj.5
        for <dmaengine@vger.kernel.org>; Thu, 09 May 2019 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oh41XTRfQ2hEQxbfWj77USA9ai+rN4+FYJEIHIYPQ50=;
        b=MSCEu1Aud2SLjXb7CPRb2JObZCwCz2T2wncAxxSLqNI+P3ZJnyYzj3LXqosy/DW9ck
         SZAQhMPo16TiwBKKf8okUSLDX/Hm1n91JYrYGiEZhydTMGNp2nlrnfV+i9+JTn+W72TY
         n2/8ImX3xbYgn3emRAen2SATySzPT9lGy8gfQpElm2W5WEr9+Vbz/XSAWCwzeZYxH8sS
         cNPRQtqo1FoCHuklAaWddmLT/arNK7bm5lZIumHgs8BbIm8OzQ6yzCx6OQilBBKlTzZ2
         mEWlYiT9255k2hQkp2z6eP0Aos4XHGjRffm85Y8fUaqZDkhdiHDVPIgeMHptgj5JfERK
         nAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oh41XTRfQ2hEQxbfWj77USA9ai+rN4+FYJEIHIYPQ50=;
        b=iojagYnlgYV+LcS0rSCU9reLIy7LgC71q6jnHPQKF+XtjMCN5tOk2ICjr7FJEaJNpX
         UBPf0LiVh3+Ghdoxw4G3ZxsUNn97iZZ0RuqPZ4VvN4nEetpcsE6zaie0B2HrXhQob/1+
         iofFddTGhqUrz8jwWJ8F/qVvtO4dCVSq3K/4fvgyFvcShqv3vn7lyGWLAo9OduEfY1JE
         csl2usb28fSsXPhLlZfYhll2QzSFBNrnNuLd8B0DF6+gLQhSzNoYDIBx2W+O9JFLO1oR
         SoEiOKupnznfwRDeB1+zXpQBGqTj9d+bvnT00urATVm6DYVVl5nK5YB7YjLF2iLFpHKH
         JYMA==
X-Gm-Message-State: APjAAAUjpJO6xMsSnmWK1y7x8J0EisqAZRghaVRDnmrUcTM814Wu/Beg
        hC/CrwRQsfmCKaC+W86W6mbgsg==
X-Google-Smtp-Source: APXvYqxGSg/jkWz4uW+fNqpxwMK3znRd6PASiue1jnbHzmriv4EAToS24KtCkbili18pFdfHiv+CWQ==
X-Received: by 2002:a2e:888d:: with SMTP id k13mr2879671lji.18.1557418848703;
        Thu, 09 May 2019 09:20:48 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.188])
        by smtp.gmail.com with ESMTPSA id d1sm426826ljc.89.2019.05.09.09.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:20:47 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: sudmac: remove unused driver
To:     Simon Horman <horms+renesas@verge.net.au>,
        Vinod Koul <vinod.koul@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20190509125211.324-1-horms+renesas@verge.net.au>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <522c16db-be05-524b-70cf-eb0dcc3c53bb@cogentembedded.com>
Date:   Thu, 9 May 2019 19:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190509125211.324-1-horms+renesas@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05/09/2019 03:52 PM, Simon Horman wrote:

> SUDMAC driver was introduced in v3.10 but was never integrated for use
> by any platform. As it unused remove it.

   "It's unused" perhaps? :-)

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
