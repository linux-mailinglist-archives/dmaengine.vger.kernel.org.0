Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB52E570520
	for <lists+dmaengine@lfdr.de>; Mon, 11 Jul 2022 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiGKOLJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jul 2022 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKOLI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jul 2022 10:11:08 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C176761B23;
        Mon, 11 Jul 2022 07:11:07 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Mon, 11 Jul
 2022 22:05:33 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.109]
Date:   Mon, 11 Jul 2022 22:05:33 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        vkoul@kernel.org, michal.simek@xilinx.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx: use strscpy to replace strlcpy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <39aa840f.e31.181ed9461c2.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBHUW8tLsxigORIAA--.939W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAECmFEYxs0ZwAAsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ClRoZSBzdHJsY3B5IHNob3VsZCBub3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXNuJ3QgbGltaXQg
dGhlIHNvdXJjZQpsZW5ndGguIFByZWZlcnJlZCBpcyBzdHJzY3B5LgoKU2lnbmVkLW9mZi1ieTog
WHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvZG1hL3hpbGlu
eC94aWxpbnhfZHBkbWEuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZHBk
bWEuYyBiL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZHBkbWEuYwppbmRleCBiMGY0OTQ4YjAw
YTUuLmY1ODE1NDY1ZTgzYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEveGlsaW54L3hpbGlueF9k
cGRtYS5jCisrKyBiL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZHBkbWEuYwpAQCAtMzc2LDcg
KzM3Niw3IEBAIHN0YXRpYyBzc2l6ZV90IHhpbGlueF9kcGRtYV9kZWJ1Z2ZzX3JlYWQoc3RydWN0
IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCiAJCWlmIChyZXQgPCAwKQogCQkJZ290byBkb25l
OwogCX0gZWxzZSB7Ci0JCXN0cmxjcHkoa2Vybl9idWZmLCAiTm8gdGVzdGNhc2UgZXhlY3V0ZWQi
LAorCQlzdHJzY3B5KGtlcm5fYnVmZiwgIk5vIHRlc3RjYXNlIGV4ZWN1dGVkIiwKIAkJCVhJTElO
WF9EUERNQV9ERUJVR0ZTX1JFQURfTUFYX1NJWkUpOwogCX0KIAotLSAKMi4yNS4xCg==
