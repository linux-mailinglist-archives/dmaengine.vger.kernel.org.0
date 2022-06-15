Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C80F54CE9B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jun 2022 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355730AbiFOQ2l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352279AbiFOQ2f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 12:28:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618B2937D;
        Wed, 15 Jun 2022 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QLrLutFCF/6krvgqQy1V+anw8vzmDDqVVQWXu6dHQBI=; b=ahTL5A/8lRfvOfzGz2hozhjzyR
        oKgB9wtZ8W601SXKNSclYHxS9eqq7bxSPX+MAEUfJRsDyZ4iBdGCWsunOfqw10C+NICQffM+AeVi2
        VR4kFIm7vK1neaBZcnpq5LiVl2WEt+e2JErA7Kpu4/do+Y17nd8KqONuAxijBpZrtci8Jki3mpzgE
        dwpV5aZGxTVKUj2vN1LZskDVcLR4ipq3/YSq8qp8jUnH0DV+FEtLKovsv0NyAvG9xC6AM0BIRyUws
        rygbDItAhKY1lOzt+9Rjg4bsWZf8GwDNxrwG522PEbARrZDgfobznVJi7SPcfjf27whR3RVQtlt4D
        C6LLRylg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1VsV-008Ab9-Qh; Wed, 15 Jun 2022 16:28:26 +0000
Message-ID: <1f8095db-a08f-7b6b-2cee-f530d914b9f8@infradead.org>
Date:   Wed, 15 Jun 2022 09:28:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: Tree for Jun 15 (drivers/dma/apple-admac.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org
References: <20220615160116.528c324b@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220615160116.528c324b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/14/22 23:01, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220614:
> 

on i386:

../drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
../drivers/dma/apple-admac.c:213:22: warning: right shift count >= width of type [-Wshift-count-overflow]
  writel_relaxed(addr >> 32,       ad->base + REG_DESC_WRITE(channo));
                      ^


-- 
~Randy
