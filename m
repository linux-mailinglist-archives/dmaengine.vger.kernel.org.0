Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5649F02E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfH0QcC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 12:32:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41187 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0QcC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 12:32:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so19235797ota.8;
        Tue, 27 Aug 2019 09:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dhRNd7yIwWwUIbw7R2NcCjUjJYu5UmK8SsYGxZLWQBk=;
        b=eTuzAMeYO+6r4cXeKg9/iPscLZlK7dF7Nn98O7SdTkUspNW5zEu9YNjG8MO8cL2qrb
         4aWs54Jy655WBHHzb8uBIODDgsT9j8ENre7Cbeu6j5+LNJECuqJ/FiniCLjAll8rKxWc
         3w9YUy5m/ZMZDOKS1ahmFiQe4eJQ3+jADIkeLYUkUj4jpg3jUNB6wJiRinkyKjYX6Jma
         QRIufh51/rM8ujMrhmELR7gy6lTte6YM8rDIPrqaK//U73R04kZqYYhgSST8r/vsmFRy
         zHFNTrIEwW3hkWHYv3ldArdGMJKYCY+F7lR//UJ9uIngghlt1hRVItF+zT8AVUHKhRo4
         xuZQ==
X-Gm-Message-State: APjAAAV06HQ5aa1R+Y63KuR3RUH2tBkE4Oe2ebd2EGsTqrVvXolT4diG
        mezXWI2y0GVoehJovzxWHA==
X-Google-Smtp-Source: APXvYqxHEgD88+9WHQA+ZuC5MA2YuedZjp45HEWvzxR2iZsyZvmBVQ+6DI3nvg7v+5nqm/Z81mSFpA==
X-Received: by 2002:a05:6830:b:: with SMTP id c11mr5630082otp.163.1566923521149;
        Tue, 27 Aug 2019 09:32:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17sm4383022oif.11.2019.08.27.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:32:00 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:31:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: milbeaut-m10v-xdmac: Add Socionext
 Milbeaut XDMAC bindings
Message-ID: <20190827163159.GA29528@bogus>
References: <20190818052154.17789-1-jassisinghbrar@gmail.com>
 <20190818052224.17857-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818052224.17857-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 18 Aug 2019 00:22:24 -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Document the devicetree bindings for Socionext Milbeaut XDMAC
> controller. Controller only supports Mem->Mem transfers. Number
> of physical channels are determined by the number of irqs registered.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/dma/milbeaut-m10v-xdmac.txt      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-xdmac.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
