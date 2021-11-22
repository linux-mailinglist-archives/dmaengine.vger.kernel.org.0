Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06634459195
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhKVPrw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 10:47:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:41009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhKVPrw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 10:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637595881;
        bh=VAaW+o1uIRbUv/clS8qcRz1aeqUmiJaltnrY8fX+G3U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WsjrjhpRaeUWptezcEGm5yAlqPr93ecbr6Vhl/dzfxPoDxckv8FdOqqXI1jgq5PMS
         e1Sk/Pk1KfsDLPMcuqp6LyQbGcNrmdkwloIo1ngcDnRwsrdwFLViy1Qzed6FvhL6am
         1DS7pQl2PZF6idwTpOFpEUaW6qcTSn6HhZ0kUPAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.10.78.233]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1n13a82Q8L-00PcPW; Mon, 22
 Nov 2021 16:44:41 +0100
Message-ID: <8e2dc5fc-b51b-1143-7eb2-8a1eed1f4d01@gmx.de>
Date:   Mon, 22 Nov 2021 16:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: compile error for 5.15.4
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
References: <747802b9-6c5d-cdb5-66e2-05b820f5213c@gmx.de>
 <YZp6yfVUx4eEwaxm@matsya> <fda4aa94-22d9-b54c-2bde-b91a579af802@gmx.de>
 <YZsZM/FqwJTqqJfj@matsya>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <YZsZM/FqwJTqqJfj@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpHBwUprH7IyiGD+C28Emzpuc/1DzCw77nxar2yBIhZs8J3MypI
 FRtSXhWGGo2RLGEHQJrw7h2eE3Xda7mSbuhv6bGNMuhv81eXZp4uLXh7t4NzaGQPhyAv1m/
 /catZ6y9/z8xKQIgA9PZc7/64fhzpSFdam+erGBqxfwi49kI/hYuyft6f0iGcUZLQE6xc6g
 DSwOYsLiYts1bDYlWbArA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g1p5IM3/Yt0=:mCl1lKEUcJ26zH8eB7qiSu
 leL64F2MV4QK5cQtD40kPG1Zt7d4VSvMyjPI3mbPJn1VdAu1bYRyjcvfILE6yHRSntBbVn3PM
 s7TI4oMKujtIwr8T+8dt+N+r0PDgwB1fIbyIp9mn3ZvuagWRg7fM6gsrWAh7bar1uNXWjXPd7
 PV/tcedSuGutwZnpfGxVp9UwyhJPdJuwoOlJZmXvjHmYW0kwVgUHizM7j8lbp3a25Zp8P8rUS
 s0mdULvq2mKYQbOwpJhdE1AZvWGn0HNqbR/eZbpj1YdDU8k9peZooMhP8efzBWesqQSACXhUe
 JBhNX1LHjVcX6jpIQEXtvkyCCHYHoQ4sBMyL16g65PqVefeehuMZqKJNjJ60S0BWNBvh9QW9A
 v+PSyTPb/WQKQ9/EO0or1C3+b6eNSAFqIz4grkQhRbRDoWrRfHjHyOPxIanrchNTik1gb2LJB
 /Q2bGJBxfMW5cm49nwuRgPrUDRW2kGn87RgzaithqC+V/1MwxkEr5HopuNVEKWfuv0eqfq5bk
 8nLEZxrEnss7FQ3Lw+HkSmfvZ6WCdhVdtMdegxwZLKU1OmM9wJLtQqXIKhSL1TlDzuj980Dcl
 AJqxnqaEtvS5APloj77uneNXFcY9fYbNEDf5NDhWCPdFl4xSUE1bJV4Kbb1hhcXAhSuk2nPe3
 n0xfxFc0H/+N1ZmMeppxUTVSdj4C2Ts3Jlf+guZ60p9Q9OOp9ttPKpq3lfZvX3USTQR1bZWDN
 OAolA1wCK+rpaato5RBmA9HKRPF8/OqCv+0Gh2B294B9vLFoqvmv8Wl8FJXmx0T+GpAJRpSK8
 mZroYlRnEmLVrM7dFiL1ESQ82C0ZidVM6NIqvtynD5Mhu5ei+oWaMN20zOkTrSl0BDmERU0zH
 9MwVnlAdDw40dv7ieHo4fFBavqgAXL+42Z6HmoRJNlLIHdZf4Ap1sQs9InQPGvOgYliuqXn4a
 vW3AFfeboUFS5ILlilgGutHyKVJ/+buJjyPqpsyd+gwcbSieynuFmYp3y39eA/yqWrD4OOhaM
 tarpoPOUKd3RMd8ebSa0Jf3PiBHY7yyjjB5SvqxHsiyah+9iAnhHlhjy/rhEhsKUu0YUoLoDD
 fBCNEwwINq4cpQ=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11/22/21 05:14, Vinod Koul wrote:
> On 21-11-21, 18:18, Toralf F=C3=B6rster wrote:
>> On 11/21/21 17:58, Vinod Koul wrote:
>>> Can you please send your config file when you saw this, which toolchai=
n
>>> was used to compile...
>>>
>>> Thanks
>> sure,
>
> This is fixed by:
> b3b180e73540 ("dmaengine: remove debugfs #ifdef")
>
> Pls confirm by cherry-picking. I will send this fix to stable.
>
confirmed - solved it.
If you want you can add a Tested-by: to the commit.

=2D-
Toralf
