Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FEDD1CDB
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2019 01:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfJIXeD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 19:34:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38782 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJIXeD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 19:34:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so3264481otl.5;
        Wed, 09 Oct 2019 16:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPc6fpcwZsUc9Gutbs7P7oeYlZYQt/DPOxeaF8rIBfI=;
        b=JJvPonkCWue/kzFo2YgbgDutNxu/QBOm+R6OUD+crqVa/AIRi67hpWGm7/KgpyVzOZ
         oPDuP5APPHpsENSmY+czgYtA4ghy3F/BRBGjy3hsCcO7ljgRjAS/ffQM/A8CZxQXsFIv
         jRVDtjRs1n3pf3uuL0BGvPqG4wR4YmGUqWt8Tnw41Pvjcn+idjx6+nrhwHFu3x5FgHRE
         S6mG6UQYhf+qLZQRNTT9dcDXNEcOL9BkNpRN8OVXQnzvBQtnZ+pCMrD12cktcuKqYOej
         QyDpg0bXa7oeaAn5b146M6z4II9ycltB4n7mwKLK5mOcpGrLgL/2WX97wOoPDXlMGRcA
         fbMw==
X-Gm-Message-State: APjAAAVbfZEbZDXdHwKa6zns0ULwNOTS3Oig+szy8AQ/xC36LFRtvQKf
        YRFJ+Ya2f0JwewbcpbtQjw==
X-Google-Smtp-Source: APXvYqzjadRfoKvbeOh4piHSXFjFjIxcKYdBtSHwZOYiSb/x+QYN70jgIyRNnwBJ14txKmB+a9qLGQ==
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr5294314otp.40.1570664042379;
        Wed, 09 Oct 2019 16:34:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 36sm1116076ott.66.2019.10.09.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:34:01 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:34:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Green Wan <green.wan@sifive.com>
Cc:     linux-hackers@sifive.com, Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yash Shah <yash.shah@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: dmaengine: sf-pdma: add bindins for
 SiFive PDMA
Message-ID: <20191009233401.GA8805@bogus>
References: <20191003090945.29210-1-green.wan@sifive.com>
 <20191003090945.29210-2-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003090945.29210-2-green.wan@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu,  3 Oct 2019 17:09:01 +0800, Green Wan wrote:
> Add DT bindings document for Platform DMA(PDMA) driver of board,
> HiFive Unleashed Rev A00.
> 
> Signed-off-by: Green Wan <green.wan@sifive.com>
> ---
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
