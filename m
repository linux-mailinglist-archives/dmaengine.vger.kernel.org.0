Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC34F05B5
	for <lists+dmaengine@lfdr.de>; Sat,  2 Apr 2022 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiDBTSS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 Apr 2022 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiDBTSR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 2 Apr 2022 15:18:17 -0400
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 12:16:23 PDT
Received: from mta-out-01.alice.it (mta-out-01.alice.it [217.169.118.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C3ECB001
        for <dmaengine@vger.kernel.org>; Sat,  2 Apr 2022 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alice.it; s=20211207; t=1648926983; 
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Date:Message-ID:MIME-Version;
        b=rnuYQ7C6pcly9brjaEhf0eD+8vH2/wAsLdVizdFRM4t2RK+OHTVTM0ChKis4sGUm0Jc66gJiHJawJHX7PTt+aoGgMAGoL70ZYX+f7KgPYxJoqyejQnzWfHBcvFgpvSUKIqEd9MhY7zzqWN2NTNqVPJc/OByS2V3qKjWzho7cHS8Y1LOSpG1+9d0DT9AWUSssPftnoiRz+r38LYCzvVYat2y2li3TXB9jZ8xDN1D4+drHsP82xrZ0nWDnz7vRd8MaYr2TLkUP+qR+DGDcsMIeDJ9gDGRjfkxW/0iDHgkCE4CiZXWiOcisjEZaW8L2DerI/MB7d+Zn0W4SpFORPmvwyw==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfvgffngfevqffokffvtefnkfetpdfqfgfvnecuuegrihhlohhuthemuceftddunecugfhmphhthicushhusghjvggtthculddutddmnefgmhhpthihucgsohguhiculdehtddmnecujfgurheprhfhvfffkfggsedttdeftddttddtnecuhfhrohhmpeghvgcuhhgrvhgvucgrnhcuohhffhgvrhcuthhouchinhhvvghsthcuihhnucihohhurhcutghouhhnthhrhicuuhhnuggvrhcurgcujhhoihhnthcuvhgvnhhtuhhrvgcuphgrrhhtnhgvrhhshhhiphcuphhlvggrshgvuchrvghplhihuchfohhruchmohhrvgcuuggvthgrihhlshcuoegsihhrohhlohesrghlihgtvgdrihhtqeenucggtffrrghtthgvrhhnpeetffeulefhheffieeltefgvedtffejhedtheefhfevueeitdeiffeuhfehudffudenucfkphepudelkedrkedrkeehrddvhedtnecuvehluhhsthgvrhfuihiivgepuddvleenucfrrghrrghmpehhvghloheprghlihgtvgdrihhtpdhinhgvthepudelkedrkedrkeehrddvhedtpdhmrghilhhfrhhomhepsghirhholhhosegrlhhitggvrdhithdpnhgspghrtghpthhtohepuddprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 60
X-RazorGate-Vade-Classification: clean
Received: from alice.it (198.8.85.250) by mta-out-01.alice.it (5.8.807.04) (authenticated as birolo@alice.it)
        id 6244775000CF9941 for dmaengine@vger.kernel.org; Sat, 2 Apr 2022 21:11:03 +0200
Reply-To: dougfied20@inbox.lv
From:   We have an offer to invest in your country under a
         joint venture partnership please reply for more
         details <birolo@alice.it>
To:     dmaengine@vger.kernel.org
Date:   02 Apr 2022 12:11:01 -0700
Message-ID: <20220402121101.3E20D8D3DF408743@alice.it>
MIME-Version: 1.0
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,BODY_EMPTY,
        DKIM_INVALID,DKIM_SIGNED,EMPTY_MESSAGE,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [217.169.118.7 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [217.169.118.7 listed in bl.mailspike.net]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [birolo[at]alice.it]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dougfied20[at]inbox.lv]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts and no
        *      Subject: text
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        *  0.0 BODY_EMPTY No body text in message
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

