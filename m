Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81AF4ECBB8
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 20:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348037AbiC3SUf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349903AbiC3SUW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 14:20:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BEA25C66
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 11:18:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w7so37285126lfd.6
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BUnAD3xqyyj2lm0zvOZVtbyxWcA123m5vBtT7P90vEA=;
        b=Bu7lF5GvgAnNDH3F8HlYgrEHBgjlXBblyOyRdTd44zrHKVUFsZbKCn79t9/sfK8wP2
         ljt5u5iSINwQqkmW0hpisCnKmjdQ69cHNrxSX/Vg87jBzt9DW7ugn5RMub8aTdbJ/sE/
         FaOGgTGuX9nd8YFJpOXBXVh8USNIodNB5sB3jaPbPNra5Sq+p6J6ZtU/UTxmVXG2pcjc
         LOCePb4egzLIwM3oa/nhOL8zAnnMkKCrEanUYy3/x/eNLzorC+CzpDglSXRRcYnutaTM
         /yM1vgaqRAH1ZzOcmJZ0quduQeF3GoWG7a6n13BzyagenGO5lUFvc1+Ke76ZdxZy0/AD
         UmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=BUnAD3xqyyj2lm0zvOZVtbyxWcA123m5vBtT7P90vEA=;
        b=hMXIh08UNOW7LEH7fspIG6exjHlXxl5OXON5bvhYbQsIllQ7qc8TYMPsuDA3pzog6/
         sko66oVpF4pS7NcNpAC6rMKvkkBmoTpgXG9iqJY0yhE/AZrppBZSMvBlUkONsRLtQ/wT
         rMjsFOEqSzjQaqF8Y+DVz41Yv+ceh0aruLl7W/ikDqCKBS7m1zRvaz7zE/XvbzqyJsJf
         pYohRkm04Smv0gUPMAyPaJGgFmyHiEI24+Gt0nRyMiLgph5CmukKBepnNLxaiBpRiXty
         az9cvFMLf0dJS0p6OJbE3BlZgAAHYI/kqq1xgSvx2ym6tfN8ASOHPdKo0aTtrjoNnvLP
         Nkgw==
X-Gm-Message-State: AOAM532EvDnvabcncxGhNge4LewRthcW7GJGcIgy0yrVSKqo/q/Q0t9K
        C81Tma8Ld4jd/mUSV/JPgYc3SrRus7N1z07/4IM=
X-Google-Smtp-Source: ABdhPJygkeutK1vPKGwlOSFbfJxggKkiEeWnN9srQepmCsfrZqgNoa7VwyiyfmaawuMb3IJfbhMJzYWtbfI8++60tag=
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id
 r2-20020a19ac42000000b004481f154b18mr7908516lfc.32.1648664300631; Wed, 30 Mar
 2022 11:18:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: isabellasayouba0@gmail.com
Sender: 33s.marshaa0@gmail.com
Received: by 2002:a05:6512:3b85:0:0:0:0 with HTTP; Wed, 30 Mar 2022 11:18:19
 -0700 (PDT)
From:   Mrs Isabella Sayouba <isabellasayouba0@gmail.com>
Date:   Wed, 30 Mar 2022 18:18:19 +0000
X-Google-Sender-Auth: X7-OLSGv59j0rGqY5VtCYorpZe0
Message-ID: <CAFsTCOrMDqcYO76g5DcFf6NPquBQhKD3MqQzYZuZfRbhrx+Y=Q@mail.gmail.com>
Subject: =?UTF-8?B?44GC44GE44GV44Gk44CC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

44GC44GE44GV44Gk44CCDQoNCua2meOCkua1geOBl+OBquOBjOOCieOBk+OBruODoeODvOODq+OC
kuabuOOBhOOBpuOBhOOBvuOBmeOAguengeOBruebruOBq+OBr+Wkp+OBjeOBquaCsuOBl+OBv+OB
jOOBguOCiuOBvuOBmeOAguengeOBruWQjeWJjeOBr+OCpOOCtuODmeODqeODu+OCteODqOOCpuOD
kOOBleOCk+OBp+OBmeOAguODgeODpeODi+OCuOOCouWHuui6q+OBp+OAgeODluODq+OCreODiuOD
leOCoeOCveOBrueXhemZouOBi+OCiemAo+e1oeOCkuWPluOCiuOBvuOBmeOAguengeOBr+OBguOB
quOBn+OBq+W/g+OCkumWi+OBhOOBpuaEn+WLleOBl+OBn+OBruOBp+OAgeOBguOBquOBn+OBq+ip
seOBmeS7peWkluOBq+mBuOaKnuiCouOBr+OBguOCiuOBvuOBm+OCk+OAguengeOBr+OAgTIwMTHl
ubTjgavkuqHjgY/jgarjgovliY3jgavjg5bjg6vjgq3jg4rjg5XjgqHjgr3jga7jg4Hjg6Xjg4vj
grjjgqLlpKfkvb/jgag55bm06ZaT5YON44GE44Gm44GE44GfU2F5b3ViYUJyb3du5rCP44Go57WQ
5ama44GX44G+44GX44Gf44CC5a2Q5L6b44Gq44GX44GnMTHlubTplpPntZDlqZrjgZfjgZ/jgIIN
Cg0K5b2844Gv44Gf44Gj44GfNeaXpemWk+e2muOBhOOBn+efreOBhOeXheawl+OBruW+jOOBp+at
u+OBq+OBvuOBl+OBn+OAguW9vOOBruatu+W+jOOAgeengeOBr+WGjeWpmuOBl+OBquOBhOOBk+OB
qOOBq+axuuOCgeOBvuOBl+OBn+OAguS6oeOBj+OBquOBo+OBn+Wkq+OBjOeUn+OBjeOBpuOBhOOB
n+OBqOOBjeOAgeW9vOOBr+e3j+mhjTg1MOS4h+ODieODq+OCkumgkOOBkeOBvuOBl+OBn+OAgg0K
77yIODAw5LiHNTAwMOODieODq++8ieilv+OCouODleODquOCq+OBruODluODq+OCreODiuODleOC
oeOCveOBrummlumDveODr+OCrOODieOCpeOCsOODvOOBrumKgOihjOOBp+OAguePvuWcqOOAgeOB
k+OBruOBiumHkeOBr+OBvuOBoOmKgOihjOOBq+OBguOCiuOBvuOBmeOAguW9vOOBr+OBk+OBruOB
iumHkeOCkuODluODq+OCreODiuODleOCoeOCveOBrumJsealreOBi+OCieOBrumHkeOBrui8uOWH
uuOBq+WIqeeUqOOBp+OBjeOCi+OCiOOBhuOBq+OBl+OBvuOBl+OBn+OAgg0KDQrmnIDov5HjgIHn
p4Hjga7ljLvogIXjga/np4HjgYznmYzjgajohLPljZLkuK3jga7llY/poYzjga7jgZ/jgoHjgas3
44O25pyI6ZaT44Gv57aa44GL44Gq44GE44Gg44KN44GG44Go56eB44Gr6KiA44GE44G+44GX44Gf
44CC56eB44KS5pyA44KC5oKp44G+44Gb44Gm44GE44KL44Gu44Gv6ISz5Y2S5Lit44Gu55eF5rCX
44Gn44GZ44CC56eB44Gu54q25oWL44KS55+l44Gj44Gf44Gu44Gn44CB56eB44Gv44GT44Gu44GK
6YeR44KS44GC44Gq44Gf44Gr5rih44GX44Gm44CB5oG144G+44KM44Gq44GE5Lq644CF44Gu5LiW
6Kmx44KS44GZ44KL44GT44Go44Gr44GX44G+44GX44Gf44CC44GC44Gq44Gf44Gv44GT44Gu44GK
6YeR44KS56eB44GM44GT44GT44Gn5oyH56S644GZ44KL5pa55rOV44Gn5Yip55So44GZ44KL44Gn
44GX44KH44GG44CC56eB44Gv44GC44Gq44Gf44Gr44GC44Gq44Gf44Gu5YCL5Lq655qE44Gq5L2/
55So44Gu44Gf44KB44Gr57eP44GK6YeR44GuMzDjg5Hjg7zjgrvjg7Pjg4jjgpLlj5bjgaPjgabm
rLLjgZfjgYTjgafjgZnjgILjgYrph5Hjga43MO+8heOBr+engeOBruWQjeWJjeOBp+WtpOWFkOmZ
ouOCkuW7uuOBpuOAgemAmuOCiuOBruiyp+OBl+OBhOS6uuOAheOCkuWKqeOBkeOCi+OBn+OCgeOB
q+S9v+OBhuOBp+OBl+OCh+OBhuOAguengeOBr+WtpOWFkOOBqOOBl+OBpuiCsuOBoeOBvuOBl+OB
n+OBjOOAgeelnuOBruWutuOCkue2reaMgeOBmeOCi+OBn+OCgeOBoOOBkeOBq+OAgeWutuaXj+OB
q+OBr+iqsOOCguOBhOOBvuOBm+OCk+OAguOBk+OBrueXheawl+OBjOengeOCkuOBqOOBpuOCguiL
puOBl+OCgeOBn+OBruOBp+OAgeelnuOBjOengeOBrue9quOCkui1puOBl+OAgealveWckuOBp+en
geOBrumtguOCkuWPl+OBkeWFpeOCjOOCi+OCiOOBhuOBq+OBk+OCjOOCkuOBl+OBpuOBhOOCi+OB
ruOBp+OBmeOAgg0KDQrov5Tkv6HjgpLlj5fjgZHlj5bjgormrKHnrKzjgIHjg5bjg6vjgq3jg4rj
g5XjgqHjgr3jga7pioDooYzjga7pgKPntaHlhYjjgpLjgYrnn6XjgonjgZvjgZfjgb7jgZnjgILj
gb7jgZ/jgIHpioDooYzjga7nj77lnKjjga7lj5flj5bkurrjgafjgYLjgovjgZPjgajjgpLoqLzm
mI7jgZnjgovmqKnpmZDmm7jjgpLnmbrooYzjgZnjgovjgojjgYbpioDooYzplbfjgavmjIfnpLrj
gZfjgb7jgZnjgILnp4HjgYzjgZPjgZPjgafov7DjgbnjgZ/jgojjgYbjgavjgYLjgarjgZ/jgYzj
gZ3jgozjgavlv5zjgZjjgabooYzli5XjgZnjgovjgZPjgajjgpLnp4Hjgavkv53oqLzjgZfjgabj
gY/jgaDjgZXjgYTjgIINCg0K44Kk44K244OZ44Op44O744K144Oo44Km44OQ5aSr5Lq644GL44KJ
44CCDQo=
