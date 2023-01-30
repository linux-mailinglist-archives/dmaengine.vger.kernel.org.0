Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4A6819A8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjA3SvC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 13:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3SvC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 13:51:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F7196A0;
        Mon, 30 Jan 2023 10:51:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C301C5C00A0;
        Mon, 30 Jan 2023 13:50:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 13:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675104656; x=1675191056; bh=N1SYOMFjtZ
        EW8WxubAAIau9AMeLMjnr5NPJeuNfPwmM=; b=Jdqe4qi5cT4ptt+dMymHQ31lNK
        vY98jaeJ5RnwlCapjadYzYuo6U0cUlXnaJqHp+5WDPj0GtXiQ2uO49BmzHJ9VSWQ
        FcBVF4AQr4nMS/fV+BuQN9hfjn3nV30oI7ZwILEx6oGgNu/2ZuMOge/RDHfhXmEp
        4AnGL7ZMc7QW5gc8D6+GVfc0V9iqIqZaP1BM/m91/RUkrMn/ty5M9Vm/xn8o+8L4
        VMvoGWA40zAzh1Zw04YekDrSGi2GBK48zonZ4a00yuXSPQtDFID6NkYofNySAHi7
        TwPJTiqS2rHQPpXodO+H2KJLkZI9hUQuKhcSVCv+Mu45f4HNRUNQbiIoI/bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675104656; x=1675191056; bh=N1SYOMFjtZEW8WxubAAIau9AMeLM
        jnr5NPJeuNfPwmM=; b=pJNLxIUuFxVp6qqnqdCUCBTzsSFr7AG3Ixy9co7y/Jrj
        ZS1f6eNK3fwbxLF3rIx18dO1Driylu2EuHq/uF90Vh5W5nAK9wrh2fsvfDzADgGv
        FotabWV+wh6mFZB9YUISgxNf956HoT4aU+fCWSqjBWWIsYKEpkty9yMMFyjVja68
        YfIisuW67DMap29M8qY7UPUGjnlS2TOEeGTUUelS7EGiHIHEFbGbegV3fRqxlTfT
        mKwJ8R83UYTPahv4d0VUX9hbtzEJZzmtiKeIYPIsEvuFTMqePdePyJVHWWEDXjNw
        gQKR17Ntxom+A7UKsTyoWiZJAq1n6WNKzwrjbMpfog==
X-ME-Sender: <xms:kBHYYyWTnyzUrpqDAipzCBOFOilEoVrfFI0-mr6BY7tJ1T2K74yXTQ>
    <xme:kBHYY-kAN2L58AbCueObhC3r6OsoVSX9Aa_syyZqQ3w2pLxNps421_vX7_OtGiYl9
    cRJTMQjAhiHN1Tsz-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kBHYY2YRaRjDtKzJix0Pgh5fhGTnY7tmyXIrEn52AvQsA8K2NQznfQ>
    <xmx:kBHYY5V4SY0chmCfVN-E9W2ojmyj23IrJoAbBQOfO6S-rmCW8gtExw>
    <xmx:kBHYY8n5PcahKwMRIXE41VwDOMaf9vJbGtqib6bMUFkNsDf_YUI4tw>
    <xmx:kBHYY24ft14YeENZ1JLMdpsSKDaW4nw1AfuNszcHCB83aY3OZ-ItJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03A7BB60086; Mon, 30 Jan 2023 13:50:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <131ceefe-a205-44e7-99be-275858b3a2df@app.fastmail.com>
In-Reply-To: <20230130171250.5ve3clop4tjv73ri@mobilestation>
References: <20230130130826.596171-1-arnd@kernel.org>
 <20230130171250.5ve3clop4tjv73ri@mobilestation>
Date:   Mon, 30 Jan 2023 19:50:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Serge Semin" <Sergey.Semin@baikalelectronics.ru>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Frank Li" <Frank.Li@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: reduce stack usage after debugfs rework
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 30, 2023, at 18:12, Serge Semin wrote:
> Hi Arnd
>
> On Mon, Jan 30, 2023 at 02:08:10PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> After the dw_edma_debugfs_entry arrays are no longer compile-time
>> constant, they take up space on the stack, which exceeds the
>> warning limit after inlining:
>> 
>> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:280:6: error: stack frame size (1784) exceeds limit (1400) in 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than]
>> void dw_edma_v0_debugfs_on(struct dw_edma *dw)
>> 
>
>> Work around this by marking the functions with the largest arrays
>> as 'noinline_for_stack' to make them not use up space on the same
>> stack together.
>
> You mean the same stack !frame!, right?

Right.
  
>> -static void dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>> +static noinline_for_stack void
>> +dw_edma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
>>  				    u16 ch, struct dentry *dent)
>
> This doesn't seem like required. Does it? This method is called from
> two functions: dw_edma_debugfs_regs_wr() and dw_edma_debugfs_regs_rd()
> and if I am not mistaken will unlikely be inlined. Even if compiler will
> inline it the stack memory consumption won't change much since the
> functions aren't called from each other.

I did this mainly for consistency, marking all the functions that
have an array of dw_edma_debugfs_entry. I have retested without this
change now and adapted the changelog accordingly.

>> @@ -159,7 +161,7 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>>  		WR_REGISTER(dw, ch67_imwr_data),
>>  		WR_REGISTER(dw, linked_list_err_en),
>>  	};
>> -	static const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>> +	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
>
> I am confused how come these locals've turned to be static const?
> Neither my patches nor the Bjorn repo provide such changes:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/dma/dw-edma/dw-edma-v0-debugfs.c?h=next#n139
> they were supposed to be just const.
>
> What repo is this patch based on?

My mistake, that was a revert from an earlier broken attempt to
fix the issue. It's fixed now after reverting the other patch
and rebasing.

>>  		/* eDMA channel context grouping */
>>  		WR_REGISTER_UNROLL(dw, engine_chgroup),
>>  		WR_REGISTER_UNROLL(dw, engine_hshake_cnt.lsb),
>> @@ -197,7 +199,8 @@ static void dw_edma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
>>  	}
>>  }
>>  
>
>> -static void dw_edma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
>> +static noinline void
>
> noinline_for_stack, right?

Fixed.

     Arnd
